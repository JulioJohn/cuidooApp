//
//  WaitingSearchBabysitterViewController.swift
//  CuidooApp
//
//  Created by Júlio John Tavares Ramos on 04/12/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import UIKit

class WaitingSearchBabysitterViewController: UIViewController {
    @IBOutlet weak var waitingBall: UIImageView!
    @IBOutlet weak var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cancelButton.layer.cornerRadius = 13
        //Adicionar um listening que verifica se a mãe aceitou
    }
    
    override func viewDidAppear(_ animated: Bool) {
        rotateView(imageView: self.waitingBall)
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        self.dismiss(animated: true) {
            print("Sumiu com essa tela!")
            //Deve deletar o match aqui
            
        }
    }
}
