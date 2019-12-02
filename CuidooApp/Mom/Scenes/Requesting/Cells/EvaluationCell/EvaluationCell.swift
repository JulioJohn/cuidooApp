//
//  EvaluationCell.swift
//  CuidooApp
//
//  Created by Victoria Andressa S. M. Faria on 27/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import UIKit

class EvaluationCell: UITableViewCell {

    @IBOutlet weak var numberOfJobs: UILabel!
    @IBOutlet weak var evaluation: UILabel!
    @IBOutlet weak var experience: UILabel!
    
    static let reuseIdentifier = "EvaluationCell"
       
       static var nib: UINib {
           let nibName = String(describing: EvaluationCell.self)
           return UINib(nibName: nibName, bundle: nil)
       }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configure(entity: EvaluationEntity) {
        self.numberOfJobs.text = entity.jobs
        self.evaluation.text = entity.evaluation
        self.experience.text = entity.experience
    }
    
}
