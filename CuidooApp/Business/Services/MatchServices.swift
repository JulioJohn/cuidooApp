//
//  MatchServices.swift
//  CuidooApp
//
//  Created by Júlio John Tavares Ramos on 25/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import Foundation
import Firebase

//FUNÇÕES BÁSICAS
class MatchServices {
    
    static func createMatch(idBaba: String, completion: @escaping (Error?) -> Void) {
        MatchDAO.createMatch(idBaba: idBaba) {
            print("Match criado com sucesso! \(idBaba)")
            completion(nil)
        }
    }
    
    static func getLoggedUser(completion: @escaping (MyUser?) -> Void) {
        UserDAO.getLoggedUser(completion: { (user) in
            completion(user)
        })
    }
    
    static func getOtherUser(isBaba: Bool, idMatch: String, completion: @escaping (MyUser?) -> (Void)) {
        var uid: String?
        MatchDAO.getMatch(idMatch: idMatch) { (match) in
            if let matche = match {
                if isBaba == true {
                    uid = matche.uidMae
                } else  {
                    uid = matche.uidBaba
                }
                UserDAO.getUser(byId: uid!) { (user) in
                    if let myUser = user {
                        UserDAO.updateInformations(byId: uid!, user: myUser) { userWithInfos in
                            if let userWithInfos = userWithInfos {
                                print("Informations do usuario atualizadas!")
                                completion(userWithInfos)
                            } else {
                                completion(nil)
                            }
                        }
                    } else {
                        completion(nil)
                    }
                }
            } else {
                print("Deu erro em pegar o match!")
            }
        }
    }
    
    static func momLikesBaba(idMom: String, matchId: String) {
        MatchDAO.momLikesBaba(idMatch: matchId, idMom: idMom) {
            
        }
    }
    
    static func userLogin(email: String, password: String, completion: @escaping () -> Void) {
        //Logar com o usuario
        UserDAO.login(email: email, password: password) {
            completion()
        }
    }
    
    static func momFinalizeMatch(completion: @escaping () -> Void) {
        MatchDAO.getMatchStatus { (status) in
            if status == "inProgress" {
                MatchDAO.changeMatchStatus(status: "Finished") {
                    print("Status modificado com sucesso!")
                    completion()
                }
            }
        }
    }
    
    static func desconnect() {
        UserDAO.disconnect {
            LoggedUser.shared.logoutUser()
        }
    }
}

//LISTENERS
extension MatchServices {
    
    static func addListener(matchId: String, completion: @escaping (StatusEnum) -> Void) {
        MatchDAO.addListener(matchId: matchId) { (status) in
            completion(transformStatusInEnum(status: status))
        }
    }
    
    static func transformStatusInEnum(status: String) -> StatusEnum{
        var statusEnum: StatusEnum = .none
        switch status {
        case "available":
            statusEnum = .available
        case "waitingBaba":
            statusEnum = .waitingBaba
        case "waitingMom":
            statusEnum = .waitingMom
        case "inProgress":
            statusEnum = .inProgress
        case "finished":
            statusEnum = .finished
        default:
            statusEnum = .none
        }
        return statusEnum
    }
}

//FUNÇÕES COMPLEXAS
extension MatchServices {
    static func changeMatchStatus(completion: @escaping () -> Void) {
        MatchDAO.getMatchStatus { (status) in
            var newStatus: String = "none"
            print("Verificando status!")
            print(status)
            switch status {
            case "available":
                newStatus = "waitingBaba"
            case "waitingBaba":
                newStatus = "waitingMom"
            case "waitingMom":
                newStatus = "inProgress"
            case "inProgress":
                newStatus = "finished"
            default:
                print("Erro na mudanca de status")
            }
            
            MatchDAO.changeMatchStatus(status: newStatus) {
                    print("Status modificado com sucesso!")
                    completion()
            }
        }
    }
    
    static func updateMatchHistory(completion: @escaping ([MatchHistory]) -> Void) {
        print("Atualizando historico de matchs")
        UserDAO.getMatchHistory { (matchHistory) in
            completion(matchHistory as! [MatchHistory])
        }
    }
    
    static func processMatch(_ match: Match, completion: @escaping (Error?) -> Void) {
        print("Processing match --> \(match.documentId)")
        MatchDAO.getMatch(idMatch: match.documentId) { (matchFound) in
            if let verifiedMatch = matchFound {
                if verifiedMatch.status == .available {
                    //OK, can be processed!
                    MatchDAO.changeMatchStatus(matchId: verifiedMatch.documentId,
                                               status: .waitingBaba) {
                                                //Mudar match atual da mãe!
                                                
                                                completion(nil)
                    }
                } else {
                    //Error: Match no longer available
                    completion(MatchFlowError.thisMatchIsNotAvailable)
                }
            } else {
                //This match is no longer available, handle error!
                completion(MatchFlowError.thisMatchIsNoLongerAvailable)
            }
        }
    }
    
    
    static func tryProcessMatch(_ list: [Match], completion: @escaping (Match?, MatchFlowError?) -> Void) {
        
        if let match = list.first {
            //Try to process first element
            processMatch(match) { (error) in
                //Check result
                if let error = error {
                    //Try next match
                    var remainingList = list
                    remainingList.removeFirst()
                    tryProcessMatch(remainingList, completion: completion)
                } else {
                    print("Deu bom!")
                    completion(match, nil)
                }
            }
        } else {
            //List is empty
            completion(nil, MatchFlowError.noAvailableMatchExists)
        }
        
    }
    
    static func tryMatchWithBabysitter(completion: @escaping (Match?, MatchFlowError?) -> Void) {
        
        MatchDAO.getAvailableMatches { (matches, error) in
            if let error = error {
                if error == .noAvailableMatchExists {
                    
                }
                print("Deu ruim!!! Trata isso aqui Crocs!")
            } else {
                if let matchList = matches {
                    tryProcessMatch(matchList) { (match, error) in
                        if let error = error {
                            if error == .noAvailableMatchExists {
                                //Se nao tiver matchs disponiveis no momento, busca a cada x segundos por um match!
                                continuousValidation { (match, error) in
                                    completion(match, error)
                                }
                            }
                            completion(nil, error)
                        } else {
                            //Deu tudo certo!
                            completion(match, nil)
                        }
                    }
                } else {
                    //No match available
                    completion(nil, MatchFlowError.noAvailableMatchExists)
                }
            }
        }
    }
    
    static func continuousValidation(completion: @escaping (Match?, MatchFlowError?) -> Void ) {
        let timer = Timer.init(timeInterval: 6.0, repeats: false) { (timer) in
            tryMatchWithBabysitter { (match, error) in
                completion(match, nil)
            }
        }
        RunLoop.main.add(timer, forMode: .common)
    }
}
