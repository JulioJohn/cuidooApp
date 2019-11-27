//
//  MatchDAO.swift
//  CuidooApp
//
//  Created by Júlio John Tavares Ramos on 26/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import Foundation
import Firebase

class MatchDAO {
    static var database = Firestore.firestore()
    static var databaseMatch = database.collection("matchs")
    static var reference: CollectionReference!
    
    /// Devolve o match com o id indicado
    /// - Parameters:
    ///   - idMatch: identificação do match
    ///   - completion: retorna um objeto do tipo Match? a ser modificado
    static func getMatch(idMatch: String, completion: @escaping (Match?) -> Void) {
        databaseMatch.document(idMatch).getDocument { (snapshot, error) in
            guard let snapData = snapshot?.data() else {
                print("Não tem match!")
                return
            }
            let actualMatch = Match(data: snapData ?? [:])
            completion(actualMatch)
        }
    }
    
    static func createMatch(idBaba: String, completion: @escaping () -> Void) {
        //Uso essa linha para definir a chave do documento como sendo a chave do Id interno
        let document = databaseMatch.document()
        
        let documentData: [String : Any] = ["documentId": "\(document.documentID)", "uidBaba": "\(idBaba)","uidMae": "none", "status": "available"]
        
        self.database.collection("users").document("\(idBaba)").updateData(["actualMatch" : document.documentID])
        
        document.setData(documentData)
        
        completion()
    }
    
    static func getAllMatchs(completion: @escaping (Match?) -> Void) {
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
    
    static func momLikesBaba(idMom: String, completion: @escaping () -> Void) {
        databaseMatch.getDocuments { (snapshot, error) in
            let matchId: String = LoggedUser.shared.actualMatch!.documentId
            databaseMatch.document(matchId).updateData(["uidMae" : idMom, "status" : "waitingBaba"])
            completion()
        }
    }
    
}
