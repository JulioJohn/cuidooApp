//
//  myUser.swift
//  CuidooApp
//
//  Created by Júlio John Tavares Ramos on 19/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import Foundation

class myUser {
    var name: String
    var uid: String
    
    init(name: String, uid: String) {
        self.name = name
        self.uid = uid
    }
    
    init?(data: [String:Any]) {
        guard let name = data["nome"] as? String else { return nil }
        guard let uid = data["uid"] as? String  else { return nil }
        
        self.name = name
        self.uid = uid
    }
    
}
