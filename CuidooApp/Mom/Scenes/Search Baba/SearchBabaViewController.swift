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
    
    @IBAction func startWorkButton(_ sender: Any) {
        if LoggedUser.shared.userIsLogged() {
            MatchServices.createMatch(idBaba: LoggedUser.shared.user!.uid)
            //Atualiza meu usuario local
            MatchServices.getUser {
                LoggedUser.shared.user!.showClass()
                //Observa se ouve mudança de status!
                MatchDAO.addListener(matchId: LoggedUser.shared.actualMatch!.documentId) { (error) in
                    print("Chamar a tela aqui!")
                }
            }
        } else {
            print("O usuário não existe")
        }
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
