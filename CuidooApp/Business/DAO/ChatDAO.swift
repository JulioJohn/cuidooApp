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
    static var chatDatabase = Firestore.firestore().collection(["matchs", LoggedUser.shared.actualMatch!.documentId, "Chat"].joined(separator: "/"))
    
    static func save(_ message: Message, completion: @escaping () -> Void) {
        chatDatabase.addDocument(data: message.representation) { error in
        if let e = error {
          print("Error sending message: \(e.localizedDescription)")
          return
        }
            completion()
      }
    }
    
}
