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
    
    // separar as staksviews
    @IBOutlet var separatorViews: [UIView]!
    

    // register
    @IBOutlet weak var registerImageView: UIImageView!
    @IBOutlet weak var registerNameTextField: UITextField!
    @IBOutlet weak var registerEmailTextField: UITextField!
    @IBOutlet weak var registerPasswordTextField: UITextField!
    
    
    // login
    @IBOutlet weak var loginEmailTextField: UITextField!
    @IBOutlet weak var loginPasswordTextField: UITextField!
    

    // constraint (USADA PARA TESTES)
    @IBOutlet weak var loginViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var registerViewTopConstraint: NSLayoutConstraint!
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
      return .lightContent
    }

    
    //MARK: Private properties
     private var selectedImage: UIImage?
     private let manager = UserManager()
     private let imageService = ImagePickerService()
     
     //MARK: Lifecycle
     override func viewDidAppear(_ animated: Bool) {
       super.viewDidAppear(animated)
      
     }
    
} // end class AuthViewController

//MARK: IBActions
extension AuthUserViewController {
    
    @IBAction func register(_ sender: Any) {
    guard let name = registerNameTextField.text, let email = registerEmailTextField.text, let password = registerPasswordTextField.text else {
      return
    }
    guard !name.isEmpty else {
      separatorViews.filter({$0.tag == 2}).first?.backgroundColor = .red
      return
    }
    guard email.isValidEmail() else {
      separatorViews.filter({$0.tag == 3}).first?.backgroundColor = .red
      return
    }
    guard password.count > 5 else {
      separatorViews.filter({$0.tag == 4}).first?.backgroundColor = .red
      return
    }
    view.endEditing(true)
    let user = AuthUser()
    user.name = name
    user.email = email
    user.password = password
    user.profilePic = selectedImage
    ThemeService.showLoading(true)
    manager.register(user: user) {[weak self] response in
      ThemeService.showLoading(false)
      switch response {
        case .failure: self?.showAlert()
        case .success: self?.dismiss(animated: true, completion: nil)
      }
    }
  }
    
@IBAction func login(_ sender: Any) {
    guard let email = loginEmailTextField.text, let password = loginPasswordTextField.text else {
      return
    }
    guard email.isValidEmail() else {
      separatorViews.filter({$0.tag == 0}).first?.backgroundColor = .red
      return
    }
    guard password.count > 5 else {
      separatorViews.filter({$0.tag == 1}).first?.backgroundColor = .red
      return
    }
    view.endEditing(true)
    let user = AuthUser()
    user.email = email
    user.password = password
    ThemeService.showLoading(true)
    manager.login(user: user) {[weak self] response in
      ThemeService.showLoading(false)
      switch response {
      case .failure: self?.showAlert()
      case .success: self?.dismiss(animated: true, completion: nil)
      }
    }
  }
    
    @IBAction func switchViews(_ sender: UIButton) {
    let shouldShowLogin = loginViewTopConstraint.constant != 30
    sender.setTitle(!shouldShowLogin ? "Login": "Crie uma nova conta", for: .normal)
    loginViewTopConstraint.constant = shouldShowLogin ? 30 : -800
    registerViewTopConstraint.constant = shouldShowLogin ? -800 : 30
    UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
      self.view.layoutIfNeeded()
    })
  }
    
  @IBAction func profileImage(_ sender: Any) {
    imageService.pickImage(from: self) {[weak self] image in
      self?.registerImageView.image = image
      self?.selectedImage = image
    }
  }
}

//MARK: UITextField Delegate
extension AuthUserViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    return textField.resignFirstResponder()
  }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    separatorViews.forEach({$0.backgroundColor = .darkGray})
  }
}

// talvez isso saia daqui (PARA TESTES)
import UIKit
import ALLoadingView

class ThemeService {
  
  static let blueColor = UIColor(red: 129.0/255.0, green: 144.0/255.0, blue: 255.0/255.0, alpha: 1)
  static let purpleColor = UIColor(red: 161.0/255.0, green: 114.0/255.0, blue: 255.0/255.0, alpha: 1)
  
  static func showLoading(_ status: Bool)  {
    if status {
      ALLoadingView.manager.messageText = ""
      ALLoadingView.manager.animationDuration = 1.0
      ALLoadingView.manager.showLoadingView(ofType: .messageWithIndicator)
      return
    }
    ALLoadingView.manager.hideLoadingView()
  }
}

extension UIViewController {
  
  func showAlert(title: String = "Error", message: String = "Something went wrong", completion: EmptyCompletion? = nil) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: {_ in
      completion?()
    }))
    present(alert, animated: true, completion: nil)
  }
}
