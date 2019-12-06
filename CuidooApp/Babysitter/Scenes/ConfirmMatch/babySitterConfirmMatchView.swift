//
//  babbySitterConfirmMatchView.swift
//  CuidooApp
//
//  Created by Victor Toon de Araújo on 29/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import UIKit

class babySitterConfirmMatchView: UIView, Nibable {

    @IBOutlet weak var babySitterImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        babySitterImageView.layer.cornerRadius = babySitterImageView.frame.height/2
        loadNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }

}
