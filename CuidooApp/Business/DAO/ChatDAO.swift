//
//  ChatDAO.swift
//  CuidooApp
//
//  Created by Júlio John Tavares Ramos on 27/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import Foundation
import Firebase

class ChatDAO {
    //Banco de dados
    private let database = Firestore.firestore()
    private var reference: CollectionReference?
    var chatDatabase: CollectionReference?
    
    init(matchId: String) {
        //LoggedUser.shared.actualMatch!.documentId
        chatDatabase = Firestore.firestore().collection(["matchs", matchId, "Chat"].joined(separator: "/"))
    }
    
    func save(_ message: Message, completion: @escaping () -> Void) {
        chatDatabase!.addDocument(data: message.representation) { error in
        if let e = error {
          print("Error sending message: \(e.localizedDescription)")
          return
        }
            completion()
      }
    }
    
    
}
