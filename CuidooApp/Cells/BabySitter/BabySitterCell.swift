//
//  BabySitterCell.swift
//  CuidooApp
//
//  Created by Victor Toon de Araújo on 18/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import UIKit

class BabySitterCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var colorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        colorView.layer.cornerRadius = 20
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            colorView.backgroundColor = .cuidooPurple
            titleLabel.textColor = .white
            timeLabel.textColor = .white
            priceLabel.textColor = .white
        } else {
            colorView.backgroundColor = .cuidooLightGrey
            titleLabel.textColor = .black
            timeLabel.textColor = .black
            priceLabel.textColor = .black
        }
    }
        
    public func configure(entity: BabySitterEntity) {
        self.titleLabel.text = entity.title
        self.priceLabel.text = entity.value
        self.timeLabel.text = entity.time
    }

}
