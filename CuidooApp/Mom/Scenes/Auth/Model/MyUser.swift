//
//  myUser.swift
//  CuidooApp
//
//  Created by Júlio John Tavares Ramos on 19/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import Foundation

class MyUser {
    var name: String
    var uid: String
    var actualMatch: String
    var isBaba: Bool
    var informations: Informations
    var matchHistory: [MatchHistory?]
    
    init?(data: [String:Any]) {
        guard let name = data["nome"] as? String else { return nil }
        guard let uid = data["uid"] as? String  else { return nil }
        guard let actualMatch = data["actualMatch"] as? String else { return nil }
        guard let isBaba = data["isBaba"] as? Bool else { return nil }
        
        self.name = name
        self.uid = uid
        self.actualMatch = actualMatch
        self.isBaba = isBaba
        
        self.matchHistory = [nil]
        self.informations = Informations()
    }
    
    func transformInDatabaseType() -> [String: Any] {
        let data: [String: Any] = ["nome" : self.name, "uid" : self.uid, "actualMatch" : self.actualMatch, "isBaba" : self.isBaba]
        return data
    }
    
    func showClass() {
        print(self.name)
        //print(self.uid)
        if self.actualMatch == "none" {
            print("Nao esta em um Match")
        } else {
            print("Esta em um Match")
        }
        print(self.actualMatch)
        self.isBaba ? print("É baba") : print("Não é babá")
    }
    
    func changeUserInformations(informations: [String: Any]) {
        self.informations = Informations(data: informations)!
    }
    
    func printInformations() {
        self.informations.printInformations()
    }
    
    func updateMatchHistory(matchHistory: [MatchHistory]) {
        self.matchHistory = matchHistory
    }
    
}
