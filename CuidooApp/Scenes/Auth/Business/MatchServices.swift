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
    
    static func updateActualMatch(idActualMatch: String, idUser: String) {
        print("Atualizou o id do match atual no servidor")
    
        //Atualiza o actualMatch do servidor
        self.database.collection("users").document("\(idUser)").updateData(["actualMatch" : idActualMatch])
     }
    
    static func getUser(completion: @escaping (MyUser?) -> Void) {
        //var userInDatabase: MyUser? = nil
        
        let user = Auth.auth().currentUser
        if let user = user {
            let uid = user.uid
            let docRef = database.collection("users").document("\(uid)")

            docRef.getDocument { (snapshot, error) in
                //Armazenando o usuario logado
                let loggedUser = MyUser(data: snapshot?.data()! ?? [:])
                completion(loggedUser)
            }
        }
    }
    
    static func getMatch(idMatch: String, completion: @escaping (Match?) -> Void) {
        self.database.collection("matchs").document(idMatch).getDocument { (snapshot, error) in
            guard let snapData = snapshot?.data() else {
                print("Não tem match!")
                return
            }
            let actualMatch = Match(data: snapData ?? [:])
            completion(actualMatch)
        }
    }
    
    //FAZER O COMPLETION DISSON, TA CRASHANDO QUANDO VOLTA PQ N DA TEMPO DE CORRIGIR!! LEMBRAR DE FAZER ISSO HOJE!!!
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
    
    static func userLogin(email: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> Void) {
        //Logar com o usuario
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    static func desconnect() {
        do {
            try Auth.auth().signOut()
            print("Desconectado!")
        } catch let signOutError as NSError {
          print ("Erro ao desconectar: %@", signOutError)
        }
    }
}
