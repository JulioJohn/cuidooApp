//
//  ChatServices.swift
//  CuidooApp
//
//  Created by Júlio John Tavares Ramos on 27/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import Foundation
import Firebase

class ChatServices {
    
    var chatDatabase: CollectionReference?
    var chatDAO: ChatDAO!
    
    init(matchId: String) {
        //LoggedUser.shared.actualMatch!.documentId
        chatDAO = ChatDAO(matchId: matchId)
    }
    
    func save(_ message: Message, completion: @escaping () -> Void) {
        self.chatDAO.save(message) {
            completion()
        }
    }
    
    func addListener(completion: @escaping (Message?,Error?) -> Void) {
        
        chatDatabase?.addSnapshotListener { (snapshot, error) in
            if let error = error {
                completion(nil, error)
            } else {
                //Success
                //Convert query to output
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
