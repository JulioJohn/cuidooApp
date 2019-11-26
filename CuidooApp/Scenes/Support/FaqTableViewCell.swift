//
//  FaqTableViewCell.swift
//  CuidooApp
//
//  Created by Victoria Andressa S. M. Faria on 25/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import UIKit

class FaqTableViewCell: UITableViewCell {

    
    static let reuseIdentifier = "FaqTableViewCell"
    static var nib: UINib {
        let nibName = String(describing: FaqTableViewCell.self)
        return UINib(nibName: nibName, bundle: nil)
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textBodyView: UILabel!
    @IBOutlet weak var backView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backView.backgroundColor = .cuidooLightGrey
        backView.layer.cornerRadius = 20
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configure (entity: FaqEntity) {
        self.titleLabel.text = entity.title
        self.textBodyView.text = entity.textBody
        
    }
    
} // end class FaqTableViewCell
