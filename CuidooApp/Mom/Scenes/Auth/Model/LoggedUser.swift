//
//  LoggedUser.swift
//  CuidooApp
//
//  Created by Júlio John Tavares Ramos on 26/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import Foundation

class LoggedUser {
    
    static let shared = LoggedUser()
    
    var user: MyUser?
    var actualMatch: Match?
    
    private init(){}
    
    func changeUser(user: MyUser?){
        self.user = user
        print("Usuario local trocado!")
    }
    
    func changeActualMatch(match: Match?) {
        self.actualMatch = match
        print("Match atual local atualizado!")
    }
    
    func userIsLogged() -> Bool {
        return self.user != nil ? true : false
    }
    
    func logoutUser() {
        self.user = nil
        print("Usuario local removido!")
    }
    
}
