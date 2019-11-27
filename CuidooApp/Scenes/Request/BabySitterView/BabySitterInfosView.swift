//
//  BabySitterInfosView.swift
//  CuidooApp
//
//  Created by Victor Toon de Araújo on 19/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import UIKit

class BabySitterInfosView: UIView, Nibable {

    @IBOutlet weak var babySitterImage: UIImageView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var heartbutton: UIButton!
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profissionLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var cuidadosLabel: UILabel!
    @IBOutlet weak var avaliationLabel: UILabel!
    @IBOutlet weak var twoYearsLabel: UILabel!
    
    
    
     @IBAction func heartButtonClick(_ sender: Any) {
        if self.heartbutton.backgroundImage(for: .normal) == UIImage(named: "heart"){
            self.heartbutton.setBackgroundImage(UIImage(named: "heart.fill"), for: .normal)
        }
        else{
            self.heartbutton.setBackgroundImage(UIImage(named: "heart"), for: .normal)
        }
     }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    

}
