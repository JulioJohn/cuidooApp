//
//  UserDAO.swift
//  CuidooApp
//
//  Created by Júlio John Tavares Ramos on 26/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import Foundation
import Firebase

class UserDAO {
    static var database = Firestore.firestore()
    static var databaseUser = database.collection("users")
        
    static func getLoggedUser(completion: @escaping (MyUser?) -> Void) {
        let user = Auth.auth().currentUser
        if let user = user {
            let uid = user.uid

            databaseUser.document("\(uid)").getDocument { (snapshot, error) in
                let user = MyUser(data: snapshot?.data()! ?? [:])
                
                //Armazenando o usuario logado
                LoggedUser.shared.changeUser(uid: uid, name: user?.name)

                //Após armazenado roda a completion
                completion(user)
            }
        }
    }
    
    static func getUser(byId: String, completion: @escaping (MyUser?) -> Void) {
        databaseUser.document("\(byId)").getDocument { (snapshot, error) in
            
            //Após armazenado roda a completion
            completion(MyUser(data: snapshot?.data()! ?? [:]))
        }
    }
    
    static func updateInformations(byId: String, user: MyUser, completion: @escaping (MyUser?) -> Void) {
        databaseUser.document(byId).collection("informations").document("1").getDocument { (snapshot, error) in
            if let infos = snapshot?.data() {
                user.changeUserInformations(informations: infos)
                completion(user)
            } else {
                print("Informaçoes nao foram atualizadas!")
                completion(nil)
            }
        }
    }
    
    static func login(email: String, password: String, completion: @escaping () -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                //Fazer o erro caso não consiga entrar
                print("Não conseguiu logar")
            } else {
                //Entrou na conta
                print("Voce logou!")
                
                completion()
            }
        }
    }
    
    static func getMatchHistory(completion: @escaping ([MatchHistory?]) -> Void) {
        let userId: String = LoggedUser.shared.uid!
        databaseUser.document(userId).collection("matchsFinalizados").getDocuments(completion: { (snapshot, error) in
            let size = (snapshot!.count - 1) as Int
            var matchs: [MatchHistory?] = []
            for i in 0 ... size {
                matchs.append(MatchHistory(data: (snapshot?.documents[i].data())!))
            }
            completion(matchs)
        })
    }
    
    static func disconnect(completion: @escaping () -> Void) {
        do {
            try Auth.auth().signOut()
            completion()
            print("Desconectado!")
        } catch let signOutError as NSError {
          print ("Erro ao desconectar: %@", signOutError)
        }
    }
}
