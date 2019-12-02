//
//  babySitterProfileViewController.swift
//  CuidooApp
//
//  Created by Victor Toon de Araújo on 29/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import UIKit

class babySitterProfileViewController: UIViewController {

    @IBOutlet weak var onlineOfflineLabel: UILabel!
    @IBOutlet weak var startJobButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startJobButtonOutlet.layer.cornerRadius = 13
        // Do any additional setup after loading the view.
    }
    
    @IBAction func startJobButtonAction(_ sender: Any) {
        
    }

}
