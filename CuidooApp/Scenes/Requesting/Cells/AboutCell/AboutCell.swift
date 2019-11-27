//
//  AboutCell.swift
//  CuidooApp
//
//  Created by Victoria Andressa S. M. Faria on 27/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import UIKit

class AboutCell: UITableViewCell {

    @IBOutlet weak var aboutBabySitterLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure (entity: aboutBabySitterEntity) {
        self.aboutBabySitterLabel.text = entity.aboutBabySitter
    }
    
} // end class AboutCell