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
            MatchServices.createMatch(idBaba: LoggedUser.shared.user!.uid)
            //Atualiza meu usuario local
            MatchServices.getUser {
                LoggedUser.shared.user!.showClass()
                //Observa se ouve mudança de status!
                MatchDAO.addListener(matchId: LoggedUser.shared.actualMatch!.documentId) { (error) in
                    self.performSegue(withIdentifier: "goToConfirmMatchSegue", sender: nil)
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
    
}
