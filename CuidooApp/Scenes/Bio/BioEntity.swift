//
//  BioEntity.swift
//  CuidooApp
//
//  Created by Victoria Andressa S. M. Faria on 25/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import Foundation

class BioEntity {
    
    var profilePicMom: String?
    var nameMom: String
    var bioMom: String
    
    init(nameMom: String, bioMom: String) {
        self.nameMom = nameMom
        self.bioMom = bioMom
    }
    
    
} // end class BioEntity
