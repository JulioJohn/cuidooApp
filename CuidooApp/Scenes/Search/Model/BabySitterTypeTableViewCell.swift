//
//  BabySitterTypeTableViewCell.swift
//  CuidooApp
//
//  Created by Victor Toon de Araújo on 18/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import UIKit

class BabySitterTypeView: UIView {

    @IBOutlet weak var babySitterType: UILabel!
    @IBOutlet weak var distanceInTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 20
    }

}
