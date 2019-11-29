//
//  ChatServices.swift
//  CuidooApp
//
//  Created by Júlio John Tavares Ramos on 27/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import Foundation

class ChatServices {
    static func save(_ message: Message, completion: @escaping () -> Void) {
        ChatDAO.save(message) {
            completion()
        }
    }

}
