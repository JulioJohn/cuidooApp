//
//  ConfigurationViewController.swift
//  CuidooApp
//
//  Created by Victoria Andressa S. M. Faria on 22/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import UIKit

class ConfigurationViewController: UITableViewController {
    
    
   
    
    @IBAction func logoutButton(_ sender: Any) {
        MatchServices.desconnect()
        performSegue(withIdentifier: "goToAuthSegue", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
    }

   


} // end class ConfigurationViewController
