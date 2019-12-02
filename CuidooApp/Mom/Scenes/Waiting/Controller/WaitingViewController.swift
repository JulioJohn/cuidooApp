//
//  WaitingViewController.swift
//  CuidooApp
//
//  Created by Júlio John Tavares Ramos on 02/12/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import UIKit

class WaitingViewController: UIViewController {
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var waitingBall: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.cancelButton.layer.cornerRadius = 15.0
        
        //FAZER UM LISTENER AQUI QUE VERIFICA SE O ESTADO DA BUSCA MODIFICOU!
    }
    
    override func viewDidAppear(_ animated: Bool) {
        rotateView(imageView: self.waitingBall)
    }

    @IBAction func cancelSearchButton(_ sender: Any) {
        performSegue(withIdentifier: "goToSearch", sender: nil)
    }
    
}
