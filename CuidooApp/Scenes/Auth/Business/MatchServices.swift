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
        //Uso essa linha para definir a chave do documento como sendo a chave do Id interno
        let ref = database.collection("matchs").document()
        
        let documentData: [String : Any] = ["documentId": "\(ref.documentID)", "uidBaba": "\(idBaba)","uidMae": "none", "status": "available"]
        
        updateActualMatch(idActualMatch: ref.documentID, idUser: idBaba)
        
        ref.setData(documentData)
    }
    
    static func updateMatch(match: Match) {
        
    }
    
    static func updateUser() {
        if !LoggedUser.shared.userIsLogged() { return }
        
        let userDatabase = self.database.collection("users")
        let userId = "\(LoggedUser.shared.user?.uid)"
        //Atualizo no database o user, baseado no user local
        userDatabase.document(userId).updateData((LoggedUser.shared.user?.transformInDatabaseType())!)
    }
    
    static func updateActualMatch(idActualMatch: String, idUser: String) {
        print("Atualizou o id do match atual no servidor")
    
        //Atualiza o actualMatch do servidor
        self.database.collection("users").document("\(idUser)").updateData(["actualMatch" : idActualMatch])
     }
    
    static func getUser(completion: @escaping () -> Void) {
        UserDAO.getUser {
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
    
    static func searchBaba(completion: @escaping (Match?) -> Void) {
        var newMatch: Match? = nil
        self.database.collection("matchs").getDocuments { (snapshot, error) in
            newMatch = Match(data: snapshot?.documents[0].data() ?? [:])!
            //Imprimindo na tela o match encontrado
            guard let match = newMatch else {
                print("Não encontrou nenhum match")
                return
            }
            match.showMatch()
            completion(newMatch)
        }
    }
    
    static func momLikesBaba(idMom: String, matchId: String) {
        let matchCollections = self.database.collection("matchs")
        matchCollections.getDocuments { (snapshot, error) in
            let matchRef = matchCollections.document(matchId)
            matchRef.updateData(["uidMae" : idMom, "status" : "waitingBaba"])
            
            print("Esta funcionando, só não esta alterando o meu usuário")
        }
    }
    
    static func userLogin(email: String, password: String, completion: @escaping () -> Void) {
        //Logar com o usuario
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                //Fazer o erro caso não consiga entrar
                print("Não conseguiu logar")
            } else {
                //Entrou na conta
                print("Voce logou!")
                
                completion()
            }
        }
    }
    
    static func desconnect() {
        do {
            try Auth.auth().signOut()
            LoggedUser.shared.logoutUser()
            print("Desconectado!")
        } catch let signOutError as NSError {
          print ("Erro ao desconectar: %@", signOutError)
        }
    }
}
