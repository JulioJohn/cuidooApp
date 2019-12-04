//
//  alertExtensions.swift
//  CuidooApp
//
//  Created by Júlio John Tavares Ramos on 04/12/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import Foundation
import UIKit

class AlertController {
    static func alertManager(alertType: AlertType) {
        var title: String = ""
        var message: String = ""
        var numberAlertActions: Int = 0
        
        var alert: UIAlertController
        
        switch alertType {
        case .cancelBabySitter:
            alert = UIAlertController(title: "Ops", message: "Não temos nenhuma cuidadora disponível na sua região no momento.", preferredStyle: .alert)
                   
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
        case .cancelCall: break
            
        case .noneBabySitter: break
            
        case .reportBabySitter: break
            
        }
    }
}
