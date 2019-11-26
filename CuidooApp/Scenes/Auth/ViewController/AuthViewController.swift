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
    
    /// Verifica qual é o usuario que esta logado
    /// - Parameter sender:
    @IBAction func howIsLogged(_ sender: Any) {
        if !(LoggedUser.shared.userIsLogged()) {
            print("Não tem usuario logado")
            return
        }
        
        LoggedUser.shared.user!.showClass()
    }
    
    @IBAction func desconectButton(_ sender: Any) {
        MatchServices.desconnect()
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
        //Atualizar o myUser local aqui com o novo actualMatch
        MatchServices.getUser { (user) in
            if let newUser = user {
                LoggedUser.shared.changeUser(user: newUser)
                OperationQueue.main.addOperation {
                    //Atualizar UI aqui
                }
            } else {
                //Erros
            }
        }
    }
    
    @IBAction func seeMatch(_ sender: Any) {
        MatchServices.getMatch(idMatch: LoggedUser.shared.user!.uid) { (match) in
            if let newMatch = match {
                LoggedUser.shared.changeActualMatch(match: newMatch)
                LoggedUser.shared.actualMatch?.showMatch()
            } else {
                //Erros
            }
        }
    }
    
    @IBAction func searchBaba(_ sender: Any) {
        MatchServices.searchBaba { (match) in
            LoggedUser.shared.changeActualMatch(match: match)
        }
    }
    
    @IBAction func momLikesBaba(_ sender: Any) {
        MatchServices.momLikesBaba(idMom: LoggedUser.shared.user!.uid, matchId: LoggedUser.shared.actualMatch!.documentId)
    }
}
