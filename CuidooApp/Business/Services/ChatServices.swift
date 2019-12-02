//
//  ChatServices.swift
//  CuidooApp
//
//  Created by Júlio John Tavares Ramos on 27/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import Foundation

class ChatServices {
    
    var chatDAO: ChatDAO!
    
    init(matchId: String) {
        chatDAO = ChatDAO(matchId: matchId)
    }
    
    func save(_ message: Message, completion: @escaping () -> Void) {
        self.chatDAO.save(message) {
            completion()
        }
    }
    
    func addListener(completion: @escaping (Message?,Error?) -> Void) {
        self.chatDAO.addListener { (message, error) in
            if let error = error {
                completion(nil, error)
            } else {
                completion(message, nil)
            }
        }
    }
    
}
