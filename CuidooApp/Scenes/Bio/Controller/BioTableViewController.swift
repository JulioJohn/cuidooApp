//
//  BioTableViewController.swift
//  CuidooApp
//
//  Created by Victoria Andressa S. M. Faria on 25/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import UIKit

class BioTableViewController: UITableViewController {


    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var nameMomLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profilePic.layer.cornerRadius = 55
        
    }
    
} // end class BioTableViewController
