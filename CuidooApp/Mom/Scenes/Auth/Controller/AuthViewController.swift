//
//  AuthViewController.swift
//  CuidooApp
//
//  Created by Júlio John Tavares Ramos on 19/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButtonOutlet: UIButton!
    
    @IBAction func backToAuthScreenUnwind(_ segue : UIStoryboardSegue){
        
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
            MatchServices.getLoggedUser(completion: { (loggedUser) in
                if let isBaba = loggedUser?.isBaba {
                    if isBaba {
                        self.performSegue(withIdentifier: "SearchBabaSegue", sender: nil)
                    } else {
                        self.performSegue(withIdentifier: "SearchSegue", sender: nil)
                    }
                } else {
                    print("Não foi possível acessar esse dado!")
                }
            })
        }
    }
}
