//
//  HistoryEntity.swift
//  CuidooApp
//
//  Created by Victoria Andressa S. M. Faria on 21/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import Foundation

class HistoryEntity {
    
    var profilePicture: String?
    var name: String?
    var timestamp: String?
    var value: Double?
    var favoriteHeart: Bool?
    var rating: Int?
    var textEvaluation: String?
    var age: String?
    var ocupation: String?
     
    init(name: String, timestamp: String, value: Double, favoriteHeart: Bool, rating: Int) {
        self.name = name
        self.timestamp = timestamp
        self.value = value
        self.favoriteHeart = favoriteHeart
        self.rating = rating
    }
    
    init(name: String, timestamp: String, rating: Int, textEvaluation: String) {
        self.name = name
        self.timestamp = timestamp
        self.rating = rating
        self.textEvaluation = textEvaluation
    }
    
    
    init(name: String?, timestamp: String?, value: Double?, favoriteHeart: Bool?, rating: Int?, age:String?, ocupation:String?) {
        self.name = name
        self.timestamp = timestamp
        self.value = value
        self.favoriteHeart = favoriteHeart
        self.rating = rating
        self.age = age
        self.ocupation = ocupation
    }
    
    // formata o valor colocando 2 casas decimais
    var valueFormatted: String { return String(format: "%.2f", value ?? 0)}
    
    
    
} // end class HistoryEntity
