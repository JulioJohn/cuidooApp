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
    
    func addListener(completion: @escaping (Message?, Error?) -> Void) {
        chatDatabase?.addSnapshotListener { (snapshot, error) in
            if let error = error {
                //Falha
                completion(nil, error)
            } else {
                //Sucesso
               snapshot!.documentChanges.forEach { change in
                    self.handleDocumentChange(change) { (message) in
                        completion(message, nil)
                    }
                }
            }
        }
    }
    
    private func handleDocumentChange(_ change: DocumentChange, completion: @escaping (Message) -> Void) {
            guard let message = Message(document: change.document) else {
                return
            }
            switch change.type {
            case .added:
                completion(message)
            default:
                break
            }
        }
    
}
