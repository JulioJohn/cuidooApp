//
//  AuthViewController.swift
//  CuidooApp
//
//  Created by Júlio John Tavares Ramos on 19/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import UIKit
import Firebase

class AuthViewController: UIViewController {

    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var database = Firestore.firestore()
    var reference: CollectionReference!
    
    var thisUser: myUser!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func loginButton(_ sender: Any) {
        //Validar os campos
        let email = userTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
                
        //Logar com o usuario
        Auth.auth().signIn(withEmail: email!, password: password!) { (result, error) in
            if error != nil {
                //Fazer o erro caso não consiga entrar
            } else {
                print("Voce logou!")
            }
        }
    }
    
    @IBAction func howIsLogged(_ sender: Any) {
        let user = Auth.auth().currentUser
        if let user = user {
            let uid = user.uid
            let docRef = database.collection("users").document("\(uid)")

            docRef.getDocument { (snapshot, error) in
                //Como pegar apenas um simples coleção: snapshot?.get("nome")
                //Estou armazenando o usuario logado
                self.thisUser = myUser(data: snapshot?.data()! ?? [:])
            }
        }
    }
    
    @IBAction func desconectButton(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            print("Desconectado!")
        } catch let signOutError as NSError {
          print ("Erro ao desconectar: %@", signOutError)
        }
    }
    
}
