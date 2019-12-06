//
//  UserServices.swift
//  CuidooApp
//
//  Created by Júlio John Tavares Ramos on 05/12/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import Foundation

class UserServices {
    static func getUser(id: String, completion: @escaping (MyUser?, Error?) -> Void) {
        UserDAO.getUser(byId: id) { (user) in
            if let user = user {
                completion(user, nil)
            } else {
                completion(nil, nil)
            }
        }
    }
}
