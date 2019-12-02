//
//  MatchHistory.swift
//  CuidooApp
//
//  Created by Júlio John Tavares Ramos on 29/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import Foundation

class MatchHistory {
    var idMatch: String
    var date: String
    var avaliation: Double
    var price: Double
    
    init?(data: [String:Any]) {
        guard let idMatch = data["idMatch"] as? String else { return nil }
        guard let date = data["date"] as? String else { return nil }
        guard let avaliation = data["avaliation"] as? Double else { return nil }
        guard let price = data["price"] as? Double else { return nil }
        
        self.idMatch = idMatch
        self.date = date
        self.avaliation = avaliation
        self.price = price
    }
    
    init() {
        self.idMatch = ""
        self.date = ""
        self.avaliation = 0.0
        self.price = 0.0
    }
    
    func printInformations() {
        print(idMatch)
        print(date)
        print(avaliation)
        print(price)
    }
}
