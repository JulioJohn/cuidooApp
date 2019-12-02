//
//  HistoryCell.swift
//  CuidooApp
//
//  Created by Victoria Andressa S. M. Faria on 19/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import UIKit

class HistoryCell: UITableViewCell {
    
    @IBOutlet weak var imageViewBabySitter: UIImageView!
    @IBOutlet weak var nameBabySitter: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    @IBOutlet var ratingStackView: [UIImageView]!
    @IBOutlet weak var favoriteHeart: UIButton!
    
    var heartFlag: Bool = false
    
    @IBAction func favoriteSelected(_ sender: Any) {
        heartFlag = !heartFlag
        setHeartImage(heartFlag)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backView.backgroundColor = .cuidooLightGrey
        backView.layer.cornerRadius = 20
        imageViewBabySitter.layer.cornerRadius = 45
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    // troca a imagem do coração ao apertar
   private func setHeartImage(_ flag: Bool) {
        if flag {
            self.favoriteHeart.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            self.favoriteHeart.imageView?.tintColor = .cuidooPink
        }
        else {
            self.favoriteHeart.setImage(UIImage(systemName: "heart"), for: .normal)
            self.favoriteHeart.imageView?.tintColor = .gray
        }
    }
    
    
    func configure(entity: HistoryEntity){
        self.nameBabySitter.text = entity.name
        self.timestampLabel.text = entity.timestamp
        self.valueLabel.text = "R$ \(entity.valueFormatted)"
        setHeartImage(entity.favoriteHeart!)
        heartFlag = entity.favoriteHeart!
        
        let rating = entity.rating!
        for star in ratingStackView {
            if star.tag < rating {
                star.image = UIImage(systemName: "star.fill")
                star.tintColor = .cuidooPink
            } else {
                star.image = UIImage(systemName: "star")
                star.tintColor = .gray
            }
        }
    }
    
    
    
} // end class HistoryCell
