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
        
        self.databaseMatch.getDocuments { (snapshot, error) in
            if snapshot!.isEmpty {
                print("Não existem matchs!")
                completion(nil)
            } else {
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
    }
    
    static func momLikesBaba(idMom: String, completion: @escaping () -> Void) {
        databaseMatch.getDocuments { (snapshot, error) in
            let matchId: String = LoggedUser.shared.actualMatch!.documentId
            databaseMatch.document(matchId).updateData(["uidMae" : idMom, "status" : "inProgress"])
            completion()
        }
    }
    
    /// Altera o status do match atual
    /// - Parameters:
    ///   - status: status novo
    ///   - completion: ao termino da alteração
    static func changeMatchStatus(status: String, completion: @escaping () -> Void) {
        let matchId: String = LoggedUser.shared.actualMatch!.documentId
        databaseMatch.document(matchId).updateData(["status" : status])
        completion()
    }
    
    static func getMatchStatus(completion: @escaping (String) -> Void) {
        let matchId: String = LoggedUser.shared.actualMatch!.documentId
        databaseMatch.document(matchId).getDocument { (snapshot, error) in
            let status = snapshot?.get("status")
            completion(status as! String)
        }
    }
    
    static func getChatFromMatch(matchId: String, completion: @escaping () -> Void) {
        databaseMatch.document(matchId).collection("Chat").getDocuments { (snapshot, error) in
            
        }
    }
    
    static func addListener(matchId: String, completion: @escaping (String) -> Void) {
        databaseMatch.addSnapshotListener { (snapshot, error) in
            snapshot?.documentChanges.forEach({ (change) in
                if change.document.documentID == matchId {
                    switch change.type {
                    case .modified:
                        //atualizar status do match atual aqui
                        let newStatus = change.document.get("status")
                        print(newStatus)
                        //deve exibir o perfil da mae aqui!!!
                        completion(newStatus as! String)
                    default:
                        break
                    }
                }
            })
        }
    }
    
}
