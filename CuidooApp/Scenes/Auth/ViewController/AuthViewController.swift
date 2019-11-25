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
                
        //Logar com o usuario
        Auth.auth().signIn(withEmail: email!, password: password!) { (result, error) in
            if error != nil {
                //Fazer o erro caso não consiga entrar
            } else {
                //Entrou na conta
                print("Voce logou!")
                self.updateMyUser()
            }
        }
    }
    
    /// Atualiza o usuario local
    func updateMyUser() {
        let user = Auth.auth().currentUser
        if let user = user {
            let uid = user.uid
            let docRef = database.collection("users").document("\(uid)")
            
            docRef.getDocument { (snapshot, error) in
                //Como pegar apenas um simples coleção: snapshot?.get("nome")
                //Estou armazenando o usuario logado
                self.thisUser = MyUser(data: snapshot?.data()! ?? [:])
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
        do {
            try Auth.auth().signOut()
            print("Desconectado!")
        } catch let signOutError as NSError {
          print ("Erro ao desconectar: %@", signOutError)
        }
    }
    
    @IBAction func createMatch(_ sender: Any) {
        let ref = database.collection("matchs").document()
        
        let documentData: [String : Any] = ["documentId": "\(ref.documentID)" ,"uidBaba": "\(self.thisUser.uid)","uidMae": "none", "status": "available"]
        updateActualMatch(idActualMatch: ref.documentID)
        ref.setData(documentData)
    }
    
    func updateActualMatch(idActualMatch: String) {
       print("Atualizou o idActualMatch")
   
       //Atualiza o actualMatch do servidor
        self.database.collection("users").document("\(self.thisUser.uid)").updateData(["actualMatch" : idActualMatch])
            
        //Atualizar o myUser local aqui com o novo actualMatch
        updateMyUser()
    }
    
    @IBAction func seeMatch(_ sender: Any) {
        self.database.collection("matchs").document(self.thisUser.actualMatch).getDocument { (snapshot, error) in
            guard let snapData = snapshot?.data() else {
                print("Não tem match!")
                return
            }
            self.actualMatch = Match(data: snapData ?? [:])
            self.actualMatch.showMatch()
        }
    }
    
    @IBAction func searchBaba(_ sender: Any) {
        //self.database.collection("users").document(self.thisUser.uid)
        self.database.collection("matchs").getDocuments { (snapshot, error) in
            let newMatch: Match = Match(data: snapshot?.documents[0].data() ?? [:])!
            newMatch.showMatch()
        }
    }
    
    @IBAction func momLikesBaba(_ sender: Any) {
        self.database.collection("matchs").getDocuments { (snapshot, error) in
            
            self.actualMatch = Match(data: snapshot?.documents[0].data() ?? [:])!
            let matchRef = self.database.collection("matchs").document(self.actualMatch.documentId)
            matchRef.updateData(["uidMae" : self.thisUser.uid, "status" : "waitingBaba"])
            print("Esta funcionando")
        }
    }
}
