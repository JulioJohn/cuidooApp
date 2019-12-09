//
//  ProfileViewController.swift
//  CuidooApp
//
//  Created by Victoria Andressa S. M. Faria on 18/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import UIKit

class ProfileViewController: UITableViewController {
    
    @IBOutlet weak var profilePicMomImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var navegationItem: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
        self.navigationController?.navigationBar.tintColor = .cuidooPink
        
        //Aqui nao é o user, é o OTHER USER ID!!!
        if let userId = LoggedUser.shared.uid {
            UserServices.getUser(id: userId) { (user, error) in
                OperationQueue.main.addOperation {
                    self.navegationItem.title = user?.name
                }
                self.nameLabel.text = "mae@teste.com"
            }
        }
        
        profilePicMomImageView.layer.cornerRadius = 65
    }

}
