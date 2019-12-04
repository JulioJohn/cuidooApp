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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startJobButtonOutlet.layer.cornerRadius = 13
    }
    
    @IBAction func startJobButtonAction(_ sender: Any) {
//        //FAZER DEIXAR OFFLINE!!! E FAZER FICAR ONLINE
//
//        if LoggedUser.shared.userIsLogged() {
//            MatchServices.createMatch(idBaba: LoggedUser.shared.user!.uid)
//            //Atualiza meu usuario local
//            MatchServices.getUser {
//                LoggedUser.shared.user!.showClass()
//                //Observa se ouve mudança de status!
//                MatchDAO.addListener(matchId: LoggedUser.shared.actualMatch!.documentId) { (error) in
//                    print("Chamar a tela aqui!")
//                }
//            }
//        } else {
//            print("O usuário não existe")
//        }
    }

}
