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
        //FAZER DEIXAR OFFLINE!!! E FAZER FICAR ONLINE
        //Verificar se tem algum match atual em progresso, se tiver, abrir a tela dele
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
            MatchServices.createMatch(idBaba: LoggedUser.shared.uid!) { (error) in
                MatchDAO.addListener(matchId: LoggedUser.shared.actualMatchID!) { (error) in
                    self.performSegue(withIdentifier: "goToConfirmMatchSegue", sender: nil)
                }
            }
        } else {
            print("O usuário não existe")
        }
    }

}


