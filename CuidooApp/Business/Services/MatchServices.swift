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
    
//    static func getUser(completion: @escaping () -> Void) {
//        UserDAO.getUser {
//            UserDAO.updateInformations {
//                print("Informacoes atualizadas")
//                LoggedUser.shared.user?.printInformations()
//                completion()
//            }
//            //O actual match local é atualizado aqui
//            if let actualMatch = LoggedUser.shared.user?.actualMatch {
//                getMatch(idMatch: actualMatch) {
//
//                }
//            }
//        }
//    }
    
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
                    uid = matche.uidBaba
                } else  {
                    uid = matche.uidMae
                }
                UserDAO.getUser(byId: uid!) { (user) in
                    if let user = user {
                        UserDAO.updateInformations(byId: uid!, user: user) {
                            print("Informations do usuario atualizadas!")
                        }
                        completion(user)
                    } else {
                        completion(nil)
                    }
                }
            } else {
                print("Deu erro em pegar o match!")
            }
        }
    }
//    
//    static func getMatch(idMatch: String, completion: @escaping () -> Void) {
//        MatchDAO.getMatch(idMatch: idMatch) { (match) in
//            if let newMatch = match {
//                //Atualiza o actualMatch
////                LoggedUser.shared.changeActualMatch(match: newMatch)
//            } else {
//                //Erros
//            }
//        }
//        completion()
//    }
    
//    func verifyActualMatch(completion: @escaping () -> Void) {
//        MatchDAO.getMatchStatus { (status) in
//            if status == "waitingBaba" || status == "waitingMom" {
//                //Se for um desses dois, pode ser deletado e procurar outro
//                let matchId = LoggedUser.shared.actualMatch?.documentId
//                MatchDAO.deleteMatch(matchId: matchId!) {
//                    print("Deletado com sucesso!")
//                }
//            }
//        }
//    }
    
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
    
    static func addListener(matchId: String, completion: @escaping (String) -> Void) {
        MatchDAO.addListener(matchId: matchId) { (status) in
            completion(status)
            print("Apareceu o perfil aqui!")
        }
    }
    
//    static func listenerActualMatch(id: String, completion: @escaping () -> Void) {
//        MatchDAO.addListener(matchId: id) { (status) in
//            completion()
//        }
//    }
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
    
//    static func updateOtherUserLocal(completion: @escaping (AlertErrors?) -> Void) {
//        //Guardar o outro usuario do match atual para recolher informações
//        //Atualiza a baba do match local
//        if LoggedUser.shared.user?.isBaba == false {
//            let babaId = LoggedUser.shared.actualMatch!.uidBaba
//            UserDAO.getUser(byId: babaId) { (user) in
//                LoggedUser.shared.actualMatch?.otherUser = user
//                UserDAO.updateInformations(byId: babaId, user: LoggedUser.shared.actualMatch!.otherUser) {
//                    print("Atualizou as informações locais do Match")
//                    completion(nil)
//                }
//            }
//        } else {
//            //Atualiza a mãe do match local
//            UserDAO.getUser(byId: LoggedUser.shared.actualMatch!.uidMae) { (user) in
//                let momId = LoggedUser.shared.actualMatch!.uidMae
//                LoggedUser.shared.actualMatch?.otherUser = user
//                UserDAO.updateInformations(byId: momId, user: LoggedUser.shared.actualMatch!.otherUser) {
//                    print("Atualizou as informacoes locais do Match")
//                    completion(nil)
//                }
//            }
//        }
//    }
    
    static func updateMatchHistory(completion: @escaping ([MatchHistory]) -> Void) {
        print("Atualizando historico de matchs")
        UserDAO.getMatchHistory { (matchHistory) in
            completion(matchHistory as! [MatchHistory])
        }
    }
    
//    static func searchBaba(completion: @escaping (AlertErrors?) -> Void) {
//        //Reseta dados locais no inicio da busca
//        LoggedUser.shared.resetAllMatchsIndex()
//
//        //Procura todos os match existentes
//        MatchDAO.getAllMatchs(completion: { (match) in
//
//            guard let matchs = match else {
//                completion(AlertErrors.noBabysitterAvailable)
//                return
//                
//            }
//            LoggedUser.shared.allMatchs = matchs
//            LoggedUser.shared.printAllMatchs()
//            completion(nil)
//        })
//    }
    
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















/*
 let index = LoggedUser.shared.allMatchsIndex
 let match = LoggedUser.shared.allMatchs![index]
 

 
 //Ver se o match existe ainda
 MatchDAO.getMatch(idMatch: match.documentId) { (verifiedMatch) in
     if verifiedMatch == nil {
         print("O match nao existe mais! E agora?")
         //Atualizar a lista de matchs local
         searchBaba { (error) in
             //Se nao tiver babas disponiveis
             if error == AlertErrors.noBabysitterAvailable {
                 //VOLTAR PARA A TELA DE SEARCH
                 //SOLTAR O ERRO!
             }
         }
     } else {
         //Verifica se está disponível
         if verifiedMatch?.status == .available {
             LoggedUser.shared.changeActualMatch(match: LoggedUser.shared.allMatchs![index])
             updateOtherUserLocal { (error) in
                 MatchServices.changeMatchStatus {
                     print("Estado modificado!")
                 }
                 completion(nil)
             }
         } else {
             //Nao esta disponivel, deve aumentar o indice e verificar se tem outro disponivel!
             if LoggedUser.shared.increaseAllMatchsIndex() {
                 tryMatchWithBabysitter { (error) in
                     if error == nil {
                         return
                     }
                 }
                 completion(.thisMatchIsNotAvailable)
             } else {
                 //Nesse caso estorou o limite, deve ser feita uma nova busca!
                 MatchServices.searchBaba { (error) in
                     print("Estorou o limite local, esta sendo feita uma nova busca!")
                 }
             }
         }
     }
     
 }
  */

