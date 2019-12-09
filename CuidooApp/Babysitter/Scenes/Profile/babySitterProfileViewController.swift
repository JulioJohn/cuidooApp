//
//  babySitterProfileViewController.swift
//  CuidooApp
//
//  Created by Victor Toon de Araújo on 29/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import UIKit

class babySitterProfileViewController: UIViewController {

    
    @IBOutlet weak var startJobButtonOutlet: UIButton!
    @IBOutlet weak var onOffButtonOutlet: UILabel!
    @IBOutlet weak var babySitterImageView: UIImageView!
    
    var isOnline:Bool = false
    
    @IBAction func goToProfileBabaUnwind(_ segue : UIStoryboardSegue){ }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startJobButtonOutlet.layer.cornerRadius = 13
        babySitterImageView.layer.cornerRadius = 65
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
        self.navigationController?.navigationBar.tintColor = .cuidooPink
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 280, height: 28))
        imageView.contentMode = .scaleAspectFit
          
        // 4
        let image = UIImage(named: "CuidooLogo")
        imageView.image = image
          
        // 5
        navigationItem.titleView = imageView
        
        removeNavegationBarLine(nav: self.navigationController!)
    }
    
    func removeNavegationBarLine(nav: UINavigationController) {
        nav.navigationBar.barTintColor = .white
        nav.navigationBar.shadowImage = UIImage()
        nav.navigationBar.layoutIfNeeded()
        nav.navigationBar.tintColor = .cuidooPink
    }
    
    func changeType() {
        if (isOnline){
            isOnline = !isOnline
            onOffButtonOutlet.text = "OFFLINE"
            startJobButtonOutlet.setTitle("Ficar online", for: .normal)
        }
        else{
            isOnline = !isOnline
            onOffButtonOutlet.text = "ONLINE"
            startJobButtonOutlet.setTitle("Ficar offline", for: .normal)
            
            //Deletar o match criado!
        }
    }
    
    @IBAction func startJobButtonAction(_ sender: Any) {
        changeType()

        if LoggedUser.shared.userIsLogged() {
            if let id = LoggedUser.shared.uid {
                MatchServices.createMatch(idBaba: id) { (error) in
                    if let matchId = LoggedUser.shared.actualMatchID {
                        MatchServices.addListener(matchId: matchId) { (status) in
                            self.statusHandle(status: status)
                        }
                    } else {
                        print("Não existe usuário logado!")
                    }
                }
            }
        } else {
            print("O usuário não existe")
        }
    }
    
    func statusHandle(status: StatusEnum) {
        if status == .waitingBaba {
            changeType()
            performSegue(withIdentifier: "goToConfirmMatchSegue", sender: nil)
        }
    }

}


