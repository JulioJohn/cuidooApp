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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startJobButtonOutlet.layer.cornerRadius = 13
        babySitterImageView.layer.cornerRadius = 65
        
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
        self.navigationController?.navigationBar.tintColor = .cuidooPink
        
        
        
       
    }
    
    @IBAction func startJobButtonAction(_ sender: Any) {
        if (isOnline){
            isOnline = !isOnline
            onOffButtonOutlet.text = "OFFLINE"
            startJobButtonOutlet.setTitle("Ficar online", for: .normal)
        }
        else{
            isOnline = !isOnline
            onOffButtonOutlet.text = "ONLINE"
            startJobButtonOutlet.setTitle("Ficar offline", for: .normal)
        }

        if LoggedUser.shared.userIsLogged() {
            if let id = LoggedUser.shared.uid {
                MatchServices.createMatch(idBaba: id) { (error) in
                    if let matchId = LoggedUser.shared.actualMatchID {
                        MatchServices.addListener(matchId: matchId) { (status) in
                            self.statusHandle(status: status)
                        }
                    } else {
                        print("NÃO EX")
                    }
                }
            }
        } else {
            print("O usuário não existe")
        }
    }
    
    func statusHandle(status: StatusEnum) {
        if status == .waitingBaba {
            performSegue(withIdentifier: "goToConfirmMatchSegue", sender: nil)
        }
    }

}


