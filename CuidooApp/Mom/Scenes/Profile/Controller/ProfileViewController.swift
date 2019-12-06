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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let userId = LoggedUser.shared.uid {
            UserServices.getUser(id: userId) { (user, error) in
                self.nameLabel.text = user?.name
            }
        }
        
        profilePicMomImageView.layer.cornerRadius = 65
    }

} // end class ProfileViewController
