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
                completion(nil)
                print("Não tem match!")
                return
            }
            let actualMatch = Match(data: snapData ?? [:])
            completion(actualMatch)
        }
    }
    
    static func getAvailableMatches(completion: @escaping ([Match]?, MatchFlowError?) -> Void) {
        databaseMatch.whereField("status", isEqualTo: "available").getDocuments { (snapshot, error) in
            //Não deu erro
            if error == nil {
                if let snapshot = snapshot {
                let matches = snapshot.documents.map { (snapshot) -> Match? in
                    Match(data: snapshot.data())
                }.compactMap { $0 }
                completion(matches, nil)
                } else {
                    completion(nil,nil)
                }
            //Deu erro
            } else {
                print(error)
                //Caso nao existam matchs disponíveis!
                completion(nil, .noAvailableMatchExists)
            }
        }
    }
    
    static func createMatch(idBaba: String, completion: @escaping () -> Void) {
        //Uso essa linha para definir a chave do documento como sendo a chave do Id interno
        let document = databaseMatch.document()
        
        let documentData: [String : Any] = ["documentId": "\(document.documentID)", "uidBaba": "\(idBaba)","uidMae": "none", "status": "available"]
        
        self.database.collection("users").document("\(idBaba)").updateData(["actualMatch" : document.documentID])
        
        LoggedUser.shared.actualMatchID = document.documentID
        
        document.setData(documentData)
        
        completion()
    }
    
    static func getAllMatchs(completion: @escaping ([Match]?) -> Void) {
        var matchsAvailable: [Match]? = []
        
        self.databaseMatch.getDocuments { (snapshot, error) in
            if snapshot!.isEmpty {
                print("Não existem matchs!")
                completion(nil)
            } else {
                for i in 0 ... (snapshot?.documents.count)! - 1 {
                    matchsAvailable?.append(Match(data: snapshot?.documents[i].data() ?? [:])!)
                }
                completion(matchsAvailable)
            }
        }
    }
    
    static func deleteMatch(matchId: String, completion: @escaping () -> Void) {
        databaseMatch.document(matchId).delete { (error) in
            if error == nil {
                completion()
            } else {
                print("Deu erro ao tentar deletar o Match!")
            }
        }
    }
    
    static func momLikesBaba(idMatch: String, idMom: String, completion: @escaping () -> Void) {
        databaseMatch.getDocuments { (snapshot, error) in
            databaseMatch.document(idMatch).updateData(["uidMae" : idMom, "status" : "inProgress"])
            completion()
        }
    }
    
    /// Altera o status do match atual
    /// - Parameters:
    ///   - status: status novo
    ///   - completion: ao termino da alteração
    static func changeMatchStatus(status: String, completion: @escaping () -> Void) {
        let matchId: String = LoggedUser.shared.actualMatchID!
        databaseMatch.document(matchId).updateData(["status" : status])
        completion()
    }
    
    static func changeMatchStatus(matchId: String,
                                  status: StatusEnum,
                                  completion: @escaping () -> Void) {
        databaseMatch.document(matchId).updateData(["status" : status.rawValue])
        completion()
    }
    
    static func getMatchStatus(completion: @escaping (String) -> Void) {
        let matchId: String = LoggedUser.shared.actualMatchID!
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
                        completion(newStatus as! String)
                    default:
                        break
                    }
                }
            })
        }
    }
    
}
