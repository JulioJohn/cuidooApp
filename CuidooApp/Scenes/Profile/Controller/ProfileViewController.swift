//
//  ProfileViewController.swift
//  CuidooApp
//
//  Created by Victoria Andressa S. M. Faria on 18/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import UIKit

class ProfileViewController: UITableViewController {
    
    
    @IBOutlet weak var profilePic: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        profilePic.layer.cornerRadius = 65
        
         
    }
    
    
    

} // end class ProfileViewController
