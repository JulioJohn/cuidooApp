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
    static var reference: CollectionReference!
    
    /// Pega o id do usuario autenticado, bate no banco e atualiza o usuario local
    /// - Parameter completion: Ocorre após atribuir valor ao usuário local atualizado
    static func getUser(completion: @escaping () -> Void) {
        let user = Auth.auth().currentUser
        if let user = user {
            let uid = user.uid
            
            databaseUser.document("\(uid)").getDocument { (snapshot, error) in
                //Armazenando o usuario logado
                LoggedUser.shared.changeUser(user: MyUser(data: snapshot?.data()! ?? [:]))
                //Após armazenado roda a completion
                completion()
            }
        }
    }
    
}
