//
//  MatchServices.swift
//  CuidooApp
//
//  Created by Júlio John Tavares Ramos on 25/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import Foundation
import Firebase

class MatchServices {
    
    static var database = Firestore.firestore()
    static var reference: CollectionReference!
    
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
                LoggedUser.shared.actualMatch?.showMatch()
            } else {
                //Erros
            }
        }
        completion()
    }
    
    static func searchBaba(completion: @escaping () -> Void) {
        MatchDAO.getAllMatchs(completion: { (match) in
            //Guardar o match atual
            LoggedUser.shared.changeActualMatch(match: match)
            
            //Guardar o outro usuario do match atual para recolher informações
            //Atualiza a baba do match local
            if LoggedUser.shared.user?.isBaba == false {
                let babaId = LoggedUser.shared.actualMatch!.uidBaba
                UserDAO.getUser(byId: babaId) { (user) in
                    LoggedUser.shared.actualMatch?.otherUser = user
                    UserDAO.updateInformations(byId: babaId, user: LoggedUser.shared.actualMatch!.otherUser) {
                        print("Atualizou as informacoes locais do Match")
                        completion()
                    }
                }
            } else {
                //Atualiza a mãe do match local
                UserDAO.getUser(byId: LoggedUser.shared.actualMatch!.uidMae) { (user) in
                    let momId = LoggedUser.shared.actualMatch!.uidMae
                    LoggedUser.shared.actualMatch?.otherUser = user
                    UserDAO.updateInformations(byId: momId, user: LoggedUser.shared.actualMatch!.otherUser) {
                        print("Atualizou as informacoes locais do Match")
                        completion()
                    }
                }
            }
        })
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
            print("Verificando status!")
            if status == "inProgress" {
                MatchDAO.changeMatchStatus(status: "Finished") {
                    print("Status modificado com sucesso!")
                    completion()
                }
            }
        }
    }
    
    //FAZER O DAO
    static func desconnect() {
        do {
            try Auth.auth().signOut()
            LoggedUser.shared.logoutUser()
            print("Desconectado!")
        } catch let signOutError as NSError {
          print ("Erro ao desconectar: %@", signOutError)
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
}