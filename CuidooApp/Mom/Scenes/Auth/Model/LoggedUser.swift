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
    var allMatchs: [Match]?
    var allMatchsIndex: Int = 0
    
    private init(){}
    
    func changeUser(user: MyUser?){
        self.user = user
        print("Usuario local trocado!")
    }
    
    func changeActualMatch(match: Match?) {
        self.actualMatch = match
        print("Match atual local atualizado!")
    }
    
    func updateAllMatchs(matchs: [Match]?) {
        self.allMatchs = matchs
        print("All matchs atualizado")
    }
    
    func resetAllMatchsIndex() {
        self.allMatchsIndex = 0
    }
    
    //Se false ultrapassou o index, se true ainda esta ok!
    func increaseAllMatchsIndex() -> Bool {
        if self.allMatchsIndex == self.allMatchs?.capacity {
            print("Ultrapassou a capacidade, a lista deve ser renovada!!")
            return false
        } else {
            self.allMatchsIndex += 1
            return true
        }
    }
    
    func printAllMatchs() {
        for i in 0 ... allMatchs!.count - 1 {
            if let match = allMatchs {
                print("Match \(i) de \(allMatchs!.count - 1) id \(match[i].documentId)")
                print("Status: \(match[i].status)")
            }
        }
    }
    
    func userIsLogged() -> Bool {
        return self.user != nil ? true : false
    }
    
    func logoutUser() {
        self.user = nil
        print("Usuario local removido!")
    }
}
