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
    
    static func createMatch(idBaba: String) {
        MatchDAO.createMatch(idBaba: idBaba) {
            
        }
    }
    
    static func getUser(completion: @escaping () -> Void) {
        UserDAO.getUser {
            UserDAO.updateInformations {
                print("Informacoes atualizadas")
                LoggedUser.shared.user?.printInformations()
                completion()
            }
            //O actual match local é atualizado aqui
            if let actualMatch = LoggedUser.shared.user?.actualMatch {
                getMatch(idMatch: actualMatch) {
                    
                }
            }
        }
    }
    
    static func getMatch(idMatch: String, completion: @escaping () -> Void) {
        MatchDAO.getMatch(idMatch: idMatch) { (match) in
            if let newMatch = match {
                //Atualiza o actualMatch
                LoggedUser.shared.changeActualMatch(match: newMatch)
            } else {
                //Erros
            }
        }
        completion()
    }
    
    func verifyActualMatch(completion: @escaping () -> Void) {
        MatchDAO.getMatchStatus { (status) in
            if status == "waitingBaba" || status == "waitingMom" {
                //Se for um desses dois, pode ser deletado e procurar outro
                let matchId = LoggedUser.shared.actualMatch?.documentId
                MatchDAO.deleteMatch(matchId: matchId!) {
                    print("Deletado com sucesso!")
                }
            }
        }
    }
    
    static func momLikesBaba(idMom: String, matchId: String) {
        MatchDAO.momLikesBaba(idMom: idMom) {
            UserDAO.updateUserActualMatch {
                print("Atualizou o match atual do usuario na nuvem!")
            }
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
    
    static func listenerActualMatch(completion: @escaping () -> Void) {
        let id = LoggedUser.shared.actualMatch?.documentId
        MatchDAO.addListener(matchId: id!) { (status) in
            if status == "available" {
                LoggedUser.shared.increaseAllMatchsIndex()
                tryMatchWithBabysitter {_ in 
                    
                }
                completion()
            }
        }
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
    
    static func updateOtherUserLocal(completion: @escaping (AlertErrors?) -> Void) {
        //Guardar o outro usuario do match atual para recolher informações
        //Atualiza a baba do match local
        if LoggedUser.shared.user?.isBaba == false {
            let babaId = LoggedUser.shared.actualMatch!.uidBaba
            UserDAO.getUser(byId: babaId) { (user) in
                LoggedUser.shared.actualMatch?.otherUser = user
                UserDAO.updateInformations(byId: babaId, user: LoggedUser.shared.actualMatch!.otherUser) {
                    print("Atualizou as informações locais do Match")
                    completion(nil)
                }
            }
        } else {
            //Atualiza a mãe do match local
            UserDAO.getUser(byId: LoggedUser.shared.actualMatch!.uidMae) { (user) in
                let momId = LoggedUser.shared.actualMatch!.uidMae
                LoggedUser.shared.actualMatch?.otherUser = user
                UserDAO.updateInformations(byId: momId, user: LoggedUser.shared.actualMatch!.otherUser) {
                    print("Atualizou as informacoes locais do Match")
                    completion(nil)
                }
            }
        }
    }
    
    static func updateMatchHistory(completion: @escaping ([MatchHistory]) -> Void) {
        print("Atualizando historico de matchs")
        UserDAO.getMatchHistory { (matchHistory) in
            print("Historico de matchs atualizado!")
            LoggedUser.shared.user?.updateMatchHistory(matchHistory: matchHistory as! [MatchHistory])
            completion(LoggedUser.shared.user!.matchHistory as! [MatchHistory])
        }
    }
    
    static func searchBaba(completion: @escaping (AlertErrors?) -> Void) {
        //Reseta dados locais no inicio da busca
        LoggedUser.shared.resetAllMatchsIndex()
        
        //Procura todos os match existentes
        MatchDAO.getAllMatchs(completion: { (match) in
            
            guard let matchs = match else {
                completion(AlertErrors.noBabysitterAvailable)
                return
            }
            LoggedUser.shared.allMatchs = matchs
            LoggedUser.shared.printAllMatchs()
            completion(nil)
        })
    }
    
    static func tryMatchWithBabysitter(completion: @escaping (MatchFlowError?) -> Void) {
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
    }
}


