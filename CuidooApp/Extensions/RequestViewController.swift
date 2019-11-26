//
//  RequestViewController.swift
//  CuidooApp
//
//  Created by Victor Toon de Araújo on 19/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import UIKit

class RequestViewController: UIViewController {

    @IBOutlet weak var babySitterView: BabySitterInfosView!
    
    @IBOutlet weak var confirm: UIButton!
    @IBOutlet weak var seeNext: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        babySitterView.layoutIfNeeded()
        babySitterView.layer.cornerRadius = 13
        confirm.layer.cornerRadius = 13
        seeNext.layer.cornerRadius = 13
        
    }

    @IBAction func didClickConfirm(_ sender: Any) {
        
    }
    
    @IBAction func didClickSeeNext(_ sender: Any) {
        
    }
    
}
