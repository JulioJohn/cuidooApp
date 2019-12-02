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
    
        profilePicMomImageView.layer.cornerRadius = 65
         
        nameLabel.text = LoggedUser.shared.user?.name
    }

} // end class ProfileViewController