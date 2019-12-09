//
//  babbySitterConfirmMatchView.swift
//  CuidooApp
//
//  Created by Victor Toon de Araújo on 29/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import UIKit

class babySitterConfirmMatchView: UIView, Nibable {

    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var babySitterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var aboutTextLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var kidsInfoLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var remunarationLabel: UILabel!
    
    @IBOutlet var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadNib()
        
        babySitterImageView.layer.cornerRadius = babySitterImageView.frame.height/2
         topView.roundCorners(corners: [.topLeft, .topRight], radius: 12)
        bottomView.roundCorners(corners: [.bottomRight, .bottomLeft], radius: 12)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        loadNib()
        
        babySitterImageView.layer.cornerRadius = babySitterImageView.frame.height/2
        topView.roundCorners(corners: [.topRight, .topLeft], radius: 12)
        bottomView.roundCorners(corners: [.bottomRight, .bottomLeft], radius: 12)
        
    }
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!    

}

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
