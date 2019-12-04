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
    @IBOutlet weak var restrictionsButton: UIButton!
    @IBOutlet weak var detailsView: UIView!
    
    @IBAction func expandButtonAction(_ sender: Any) {
        UIView.animate(withDuration: 0.2) {
            self.favoritesView.isHidden = !self.favoritesView.isHidden
            self.detailsView.isHidden = !self.detailsView.isHidden
            
            if self.favoritesView.isHidden{
                self.restrictionsButton.setBackgroundImage(UIImage(named: "Mais restricoes"), for: .normal)
            }else{
                self.restrictionsButton.setBackgroundImage(UIImage(named: "Menos restricoes"), for: .normal)
            }
        }
        delegate?.didClickExpand()
    }
    
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
