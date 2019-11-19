//
//  AuthViewController.swift
//  CuidooApp
//
//  Created by Júlio John Tavares Ramos on 19/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import UIKit
import FirebaseAuth

class AuthViewController: UIViewController {

    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func loginButton(_ sender: Any) {
        //Validar os campos
        let email = userTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        //Logar com usuário
        Auth.auth().signIn(withEmail: email! , link: password!) { (result, error) in
            
            if error != nil {
                //Fazer o erro caso não consiga entrar
            } else {
                
            }
        }
    }
}
