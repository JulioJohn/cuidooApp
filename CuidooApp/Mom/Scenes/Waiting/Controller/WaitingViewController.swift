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
        
        //Listener que verifica se o estado atual mudou!
        MatchServices.addListener(matchId: LoggedUser.shared.actualMatch!.documentId) { (status) in
            //se for recusado, deve ser chamado o search novamente, atualisado o actual match
            //se for aceito, deve pular para a tela de request
            if status == "waitingMom" {
                print("Aguardando mãe aceitar baba!")
                self.performSegue(withIdentifier: "goToRequest", sender: nil)
            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        rotateView(imageView: self.waitingBall)
    }

    @IBAction func cancelSearchButton(_ sender: Any) {
        performSegue(withIdentifier: "goToSearch", sender: nil)
    }
    
}
