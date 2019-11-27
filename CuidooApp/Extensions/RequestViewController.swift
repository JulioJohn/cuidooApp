//
//  RequestViewController.swift
//  CuidooApp
//
//  Created by Victor Toon de Araújo on 19/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import UIKit

class RequestViewController: UIViewController {

    @IBOutlet weak var babySitterView: BabySitterInfosView!
    
    @IBOutlet weak var confirm: UIButton!
    @IBOutlet weak var seeNext: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        babySitterView.layoutIfNeeded()
        babySitterView.layer.cornerRadius = 13
        confirm.layer.cornerRadius = 13
        seeNext.layer.cornerRadius = 13
        
        //TEM QUE DEMORAR PARA PULAR PARA ESSA TELA, TA PULANDO MUITO CEDO!!
        let otherUser = (LoggedUser.shared.actualMatch?.otherUser)!
        babySitterView.setInformations(name: otherUser.name, informations: otherUser.informations)
        
    }

    @IBAction func didClickConfirm(_ sender: Any) {
        MatchServices.momLikesBaba(idMom: LoggedUser.shared.user!.uid, matchId: LoggedUser.shared.actualMatch!.documentId)
    }
    
    @IBAction func didClickSeeNext(_ sender: Any) {
        
    }
    
}
