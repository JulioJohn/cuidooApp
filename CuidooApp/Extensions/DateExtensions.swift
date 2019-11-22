//
//  DateExtensions.swift
//  CuidooApp
//
//  Created by Victoria Andressa S. M. Faria on 21/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import Foundation

extension Date {
    
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        
        let result = formatter.string(from: self)
        return result
    }
    
}
