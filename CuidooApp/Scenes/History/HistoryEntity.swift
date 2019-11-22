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
    var name: String
    var timestamp: Date
    var value: Double
    var favoriteHeart: Bool
    var rating: Int
    
    
    init(name: String, timestamp: Date, value: Double, favoriteHeart: Bool, rating: Int) {
        self.name = name
        self.timestamp = timestamp
        self.value = value
        self.favoriteHeart = favoriteHeart
        self.rating = rating
    }
    
    // formata o valor colocando 2 casas decimais
    var valueFormatted: String { return String(format: "%.2f", value)}
    
    
} // end class HistoryEntity
