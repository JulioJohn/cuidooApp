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
    @IBOutlet weak var babySItterImageOutlet: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startJobButtonOutlet.layer.cornerRadius = 13
       
    }
    
    @IBAction func startJobButtonAction(_ sender: Any) {
        //FAZER DEIXAR OFFLINE!!! E FAZER FICAR ONLINE
        //Verificar se tem algum match atual em progresso, se tiver, abrir a tela dele

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


