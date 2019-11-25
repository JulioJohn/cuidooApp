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
    
    static func createMatch(idBaba: Int) {
        //Uso essa linha para definir a chave do documento como sendo a chave do Id interno
        let ref = database.collection("matchs").document()
        
        let documentData: [String : Any] = ["documentId": "\(ref.documentID)", "uidBaba": "\(idBaba)","uidMae": "none", "status": "available"]
        
        updateActualMatch(idActualMatch: ref.documentID, idUser: idBaba)
        
        ref.setData(documentData)
    }
    
    static func updateMatch(match: Match) {
        
    }
    
    static func updateActualMatch(idActualMatch: String, idUser: Int) {
        print("Atualizou o id do match atual no servidor")
    
        //Atualiza o actualMatch do servidor
        self.database.collection("users").document("\(idUser)").updateData(["actualMatch" : idActualMatch])
             
         //Atualizar o myUser local aqui com o novo actualMatch
     }
    
    static func getUser() -> User? {
        let user = Auth.auth().currentUser
        if let user = user {
            let uid = user.uid
            let docRef = database.collection("users").document("\(uid)")

            docRef.getDocument { (snapshot, error) in
                //Como pegar apenas um simples coleção: snapshot?.get("nome")
                //Estou armazenando o usuario logado
                return MyUser(data: snapshot?.data()! ?? [:])
            }
        }
        return nil
    }
}
