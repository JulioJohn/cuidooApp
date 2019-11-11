//
//  UserViewController.swift
//  CuidooApp
//
//  Created by Victoria Andressa S. M. Faria on 10/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import UIKit

class AuthUserViewController: UIViewController {

    //MARK: IBOutlets
    
    @IBOutlet var separatorViews: [UIView]!
    
    // register
    @IBOutlet weak var registerImageView: UIImageView!
    @IBOutlet weak var registerNameTextField: UITextField!
    @IBOutlet weak var registerEmailTextField: UITextField!
    @IBOutlet weak var registerPasswordTextField: UITextField!
    
    // login
    @IBOutlet weak var loginEmailTextField: UITextField!
    @IBOutlet weak var loginPasswordTextField: UITextField!
    
    // Constraint 
    @IBOutlet weak var loginViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var registerViewTopConstraint: NSLayoutConstraint!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
      return .lightContent
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    

} // end class AuthVireController
