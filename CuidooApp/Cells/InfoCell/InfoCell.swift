//
//  InfoCell.swift
//  CuidooApp
//
//  Created by Victor Toon de Araújo on 18/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import UIKit

protocol InfoCellDelegate: class {
    func didClickExpand()
}

class InfoCell: UITableViewCell {

    private weak var delegate: InfoCellDelegate?
    @IBOutlet weak var favoritesView: UIView!

    
    func configure(delegate: InfoCellDelegate){
        self.delegate = delegate
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func didClickExpand(_ sender: Any) {
        print("lala")
    }
    
}
