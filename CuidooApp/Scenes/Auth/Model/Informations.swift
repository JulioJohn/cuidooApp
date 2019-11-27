//
//  Informations.swift
//  CuidooApp
//
//  Created by Júlio John Tavares Ramos on 27/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import Foundation

class Informations {
    var avaliation: Double
    var cuidados: Int
    var experience: String
    var profission: String
    var description: String
    
    init?(data: [String:Any]) {
        guard let avaliation = data["avaliacao"] as? Double else { return nil }
        guard let cuidados = data["cuidados"] as? Int else { return nil }
        guard let experience = data["experiencia"] as? String else { return nil }
        guard let profission = data["profissao"] as? String else { return nil }
        guard let description = data["descricao"] as? String else { return nil }
        
        self.avaliation = avaliation
        self.cuidados = cuidados
        self.experience = experience
        self.profission = profission
        self.description = description
    }
    
    init() {
        self.avaliation = 0.00
        self.cuidados = 666
        self.experience = ""
        self.profission = ""
        self.description = ""
    }
    
    func printInformations() {
        print(avaliation)
        print(cuidados)
        print(experience)
        print(profission)
        print(description)
    }
}
