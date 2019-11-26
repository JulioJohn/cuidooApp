//
//  BabySitterInfosView.swift
//  CuidooApp
//
//  Created by Victor Toon de Araújo on 19/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import UIKit

class BabySitterInfosView: UIView {

    @IBOutlet weak var babySitterImage: UIImageView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var heartbutton: UIButton!
    
     @IBAction func heartButtonClick(_ sender: Any) {
        if self.heartbutton.backgroundImage(for: .normal) == UIImage(named: "heart"){
            self.heartbutton.setBackgroundImage(UIImage(named: "heart.fill"), for: .normal)
        }
        else{
            self.heartbutton.setBackgroundImage(UIImage(named: "heart"), for: .normal)
        }
     }
     // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    

}
