//
//  ConfirmMatchViewController.swift
//  CuidooApp
//
//  Created by Victor Toon de Araújo on 04/12/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import UIKit

class ConfirmMatchViewController: UIViewController {
    
    @IBOutlet weak var babySitterConfirmMatchView: babySitterConfirmMatchView!
    @IBOutlet weak var acceptButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func acceptButton(_ sender: Any) {
        self.acceptButton.isEnabled = false
        MatchServices.changeMatchStatus {
            print("Aparece a tela de waiting da baba aqui!")
            self.acceptButton.isEnabled = true
        }
    }
    
}
