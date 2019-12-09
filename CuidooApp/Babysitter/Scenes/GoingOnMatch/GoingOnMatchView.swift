//
//  GoingOnMatch.swift
//  CuidooApp
//
//  Created by Júlio John Tavares Ramos on 04/12/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import UIKit

class GoingOnMatchView: UIView, Nibable {
    
    @IBOutlet weak var momImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var detailsTextLabel: UILabel!
    @IBOutlet weak var kidsLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var remunerationLabel: UILabel!
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
        
        setInformations()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
        
        setInformations()
    }
    
    func setInformations() {
        topView.roundCorners(corners: [.topLeft, .topRight], radius: 12)
        bottomView.roundCorners(corners: [.bottomRight, .bottomLeft], radius: 12)
        momImageView.layer.cornerRadius = momImageView.frame.height/2
    }
}
