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
    
    var thisUser: MyUser!
    var actualMatch: Match!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func loginButton(_ sender: Any) {
        //Validar os campos
        let email = userTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
         
        
        MatchServices.userLogin(email: email ?? "", password: password ?? "") { (result, error) in
            if error != nil {
                //Fazer o erro caso não consiga entrar
                print("Não conseguiu logar")
            } else {
                //Entrou na conta
                print("Voce logou!")
                self.updateMyLocalUser()
            }
        }
    }
    
    /// Verifica qual é o usuario que esta logado
    /// - Parameter sender:
    @IBAction func howIsLogged(_ sender: Any) {
        if let user = self.thisUser {
            user.showClass()
        }
        else {
            print("Não tem usuario logado")
            return
        }
    }
    
    @IBAction func desconectButton(_ sender: Any) {
        MatchServices.desconnect()
    }
    
    @IBAction func createMatch(_ sender: Any) {
        guard let user = self.thisUser else {
            print("O usuário não existe")
            return
        }
        MatchServices.createMatch(idBaba: user.uid)
        
        updateMyLocalUser()
    }
    
    /// Atualiza o usuario local
    func updateMyLocalUser() {
        //Atualizar o myUser local aqui com o novo actualMatch
        MatchServices.getUser { (user) in
            if let newUser = user {
                self.thisUser = newUser
                OperationQueue.main.addOperation {
                    //Atualizar UI aqui
                }
            } else {
                //Erros
            }
        }
    }
    
    @IBAction func seeMatch(_ sender: Any) {
        MatchServices.getMatch(idMatch: self.thisUser.actualMatch) { (match) in
            if let newMatch = match {
                self.actualMatch = newMatch
                self.actualMatch.showMatch()
            } else {
                //Erros
            }
        }
    }
    
    @IBAction func searchBaba(_ sender: Any) {
        MatchServices.searchBaba { (match) in
            self.actualMatch = match
        }
    }
    
    @IBAction func momLikesBaba(_ sender: Any) {
        MatchServices.momLikesBaba(idMom: self.thisUser.uid, matchId: self.actualMatch.documentId)
    }
}
