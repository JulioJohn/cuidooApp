//
//  DataPictureCell.swift
//  CuidooApp
//
//  Created by Victoria Andressa S. M. Faria on 27/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import UIKit

class DataPictureCell: UITableViewCell {
    
    
    @IBOutlet weak var babySitterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var ocupationLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.babySitterImage.layer.cornerRadius = 65
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(entity: HistoryEntity){
        self.nameLabel.text = entity.name
        self.ageLabel.text = entity.age
        self.ocupationLabel.text = entity.ocupation
    }
    
}
