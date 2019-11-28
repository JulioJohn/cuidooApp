//
//  SearchBabaViewController.swift
//  CuidooApp
//
//  Created by Júlio John Tavares Ramos on 27/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import UIKit

class SearchBabaViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func startWorkButton(_ sender: Any) {
        if LoggedUser.shared.userIsLogged() {
            MatchServices.createMatch(idBaba: LoggedUser.shared.user!.uid)
            //Atualiza meu usuario local
            MatchServices.getUser {
                LoggedUser.shared.user!.showClass()
                OperationQueue.main.addOperation {
                    //Atualizar UI aqui
                }
            }
        } else {
            print("O usuário não existe")
        }
    }
    
    @IBAction func acceptButton(_ sender: Any) {
        
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        
    }
    
    @IBAction func leaveButton(_ sender: Any) {
        dismiss(animated: true) {
            MatchServices.desconnect()
        }
    }
}
