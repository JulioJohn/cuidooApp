//
//  Match.swift
//  CuidooApp
//
//  Created by Júlio John Tavares Ramos on 22/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import Foundation

class Match {
    var documentId: String
    var status: StatusEnum
    var uidBaba: String
    var uidMae: String
    
    init?(data: [String:Any]) {
        guard let documentId = data["documentId"] as? String else { return nil }
        guard let status = data["status"] as? String else { return nil }
        guard let uidBaba = data["uidBaba"] as? String else { return nil }
        guard let uidMae = data["uidMae"] as? String else { return nil }
        
        self.documentId = documentId
        self.uidBaba = uidBaba
        self.status = StatusEnum.none
        self.uidMae = uidMae
        
        self.status = transformEnum(inStatus: status)
    }
    
    func transformEnum(inStatus: String) -> StatusEnum {
        switch inStatus {
        case "available":
            return StatusEnum.available
        case "waitingBaba":
            return StatusEnum.waitingBaba
        case "inProgress":
            return StatusEnum.inProgress
        case "finished":
            return StatusEnum.finished
        default:
            return StatusEnum.none
        }
    }
    
    func showMatch() {
        print(documentId)
        print(status)
        print(uidBaba)
        print(uidMae)
    }
}
