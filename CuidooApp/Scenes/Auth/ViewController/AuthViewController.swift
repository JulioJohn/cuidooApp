//
//  AuthViewController.swift
//  CuidooApp
//
//  Created by Júlio John Tavares Ramos on 19/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {

    //LEMBRAR: POSSO FAZER UM LISTENER NO FIREBASE PARA MEU USUARIO/MATCH LOCAIS, MAS PARA ISSO PRECISAREI DE UM LISTENER LOCAL PARA ESSE LISTENER
    
    //Outlets
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func loginButton(_ sender: Any) {
        //Validar os campos
        let email = userTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
         
        
        MatchServices.userLogin(email: email, password: password) {
            self.updateMyLocalUser()
        }
    }
    
    @IBAction func createMatch(_ sender: Any) {
        if LoggedUser.shared.userIsLogged() {
            MatchServices.createMatch(idBaba: LoggedUser.shared.user!.uid)
            updateMyLocalUser()
        } else {
            print("O usuário não existe")
        }
    }
    
    /// Atualiza o usuario local
    func updateMyLocalUser() {
        MatchServices.getUser {
            LoggedUser.shared.user!.showClass()
            OperationQueue.main.addOperation {
                //Atualizar UI aqui
            }
        }
    }
    
    @IBAction func seeMatch(_ sender: Any) {
        MatchServices.getMatch(idMatch: LoggedUser.shared.user!.actualMatch) { () in
            
        }
    }
}
