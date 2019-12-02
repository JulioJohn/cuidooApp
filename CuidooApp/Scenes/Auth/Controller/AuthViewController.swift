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
    @IBOutlet weak var loginButtonOutlet: UIButton!
    

    @IBAction func unwindHere(_ segue : UIStoryboardSegue){
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginButtonOutlet.layer.cornerRadius = 13
    }

    @IBAction func loginButton(_ sender: Any) {
        //Validar os campos
        let email = userTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
         
        
        MatchServices.userLogin(email: email, password: password) {
            //Atualiza meu usuario local
            MatchServices.getUser {
                LoggedUser.shared.user!.showClass()
                if LoggedUser.shared.user!.isBaba {
                    self.performSegue(withIdentifier: "SearchBabaSegue", sender: nil)
                } else {
                    self.performSegue(withIdentifier: "SearchSegue", sender: nil)
                }
                OperationQueue.main.addOperation {
                    //Atualizar UI aqui
                }
            }
        }
    }
}
