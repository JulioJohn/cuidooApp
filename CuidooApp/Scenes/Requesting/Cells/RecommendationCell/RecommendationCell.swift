//
//  RecommendationCell.swift
//  CuidooApp
//
//  Created by Victoria Andressa S. M. Faria on 27/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import UIKit

class RecommendationCell: UITableViewCell {

    
    @IBOutlet weak var imageViewBabySitter: UIImageView!
    @IBOutlet weak var nameBabySitter: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet var ratingStackView: [UIImageView]!
    @IBOutlet weak var textEvaluationLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    
    static let reuseIdentifier = "RecommendationCell"
    
    static var nib: UINib {
        let nibName = String(describing: RecommendationCell.self)
        return UINib(nibName: nibName, bundle: nil)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backView.backgroundColor = .cuidooLightGrey
        backView.layer.cornerRadius = 20
        imageViewBabySitter.layer.cornerRadius = 22
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(entity: HistoryEntity){
        self.nameBabySitter.text = entity.name
        self.timestampLabel.text = entity.timestamp!.toString()
        self.textEvaluationLabel.text  = entity.textEvaluation
        
        // rating star
        let rating = entity.rating
        for star in ratingStackView {
            if star.tag < rating! {
                star.image = UIImage(systemName: "star.fill")
                star.tintColor = .cuidooPink
            } else {
                star.image = UIImage(systemName: "star")
                star.tintColor = .gray
            }
        }
    }
    
} // end class RecommendationCell
