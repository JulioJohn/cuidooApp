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
        
        if LoggedUser.shared.userIsLogged() {
            if let id = LoggedUser.shared.actualMatchID {
                //Observa se ouve mudança de status!
                MatchServices.addListener(matchId: id) { (status) in
                    self.handleStatus(status: status)
                }
            }
        } else {
            print("O usuário não existe")
        }
    }
    
    @IBAction func acceptButton(_ sender: Any) {
        self.acceptButton.isEnabled = false
        MatchServices.changeMatchStatus {
            self.acceptButton.isEnabled = true
            self.performSegue(withIdentifier: "goToWaitingBabysitterSegue", sender: nil)
        }
    }
    
    @IBAction func denniedButton(_ sender: Any) {
        self.performSegue(withIdentifier: "goToProfileBabaSegue", sender: nil)
    }
    
    func handleStatus(status: StatusEnum) {
        if status == .available {
            self.performSegue(withIdentifier: "goToSearchSegue", sender: nil)
        }
    }
    
}
