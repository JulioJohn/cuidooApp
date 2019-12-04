//
//  SearchBabaViewController.swift
//  CuidooApp
//
//  Created by Júlio John Tavares Ramos on 27/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import UIKit

class SearchBabaViewController: UIViewController {

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
    
    @IBAction func cancelButton(_ sender: Any) {
        
    }
    
    @IBAction func leaveButton(_ sender: Any) {
        dismiss(animated: true) {
            MatchServices.desconnect()
        }
    }
}
