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
    
}
