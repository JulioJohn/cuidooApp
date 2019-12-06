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
    
    let actualMatchID = LoggedUser.shared.actualMatchID
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        babySitterView.layoutIfNeeded()
        babySitterView.layer.cornerRadius = 13
        confirm.layer.cornerRadius = 13
        seeNext.layer.cornerRadius = 13
        
        MatchServices.getOtherUser(isBaba: false, idMatch: actualMatchID!) { (otherUser) -> (Void) in
            if let otherUser = otherUser {
                DispatchQueue.main.async {
                    self.babySitterView.setInformations(name: otherUser.name, informations: otherUser.informations)
                }
            } else {
                //Nao pegou nenhum usuario
            }
        }
    }

    @IBAction func didClickConfirm(_ sender: Any) {
        let uid = LoggedUser.shared.uid!
        if let matchId = self.actualMatchID{
            MatchServices.momLikesBaba(idMom: uid, matchId: matchId)
            performSegue(withIdentifier: "requestingSegue", sender: nil)
        }
    }
    
    @IBAction func didClickSeeNext(_ sender: Any) {
        performSegue(withIdentifier: "goToWaitingSearchSegue", sender: nil)
    }
    
}
