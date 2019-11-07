//
//  RootViewController.swift
//  CuidooApp
//
//  Created by Júlio John Tavares Ramos on 06/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import UIKit
import FirebaseDatabase

class RootViewController: UIViewController {

    @IBOutlet weak var nameLabel: UITextField!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ref = Database.database().reference()
    }
    
    //adiciona o usuario no firebase
    @IBAction func registerButtonAction(_ sender: UIButton) {
        let actualText = self.nameLabel.text
        self.ref.child("Usuarios").childByAutoId().child("Nome").setValue("\(actualText ?? "Bugou o nome")")
    }
    @IBAction func editingBegin(_ sender: Any) {
        self.nameLabel.text = ""
    }
}
