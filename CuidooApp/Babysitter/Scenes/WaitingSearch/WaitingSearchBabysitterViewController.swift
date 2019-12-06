//
//  WaitingSearchBabysitterViewController.swift
//  CuidooApp
//
//  Created by Júlio John Tavares Ramos on 04/12/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import UIKit

class WaitingSearchBabysitterViewController: UIViewController {
    @IBOutlet weak var waitingBall: UIImageView!
    @IBOutlet weak var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cancelButton.layer.cornerRadius = 13
        
        if LoggedUser.shared.userIsLogged() {
            if let matchId = LoggedUser.shared.actualMatchID {
                MatchServices.addListener(matchId: matchId) { (status) in
                    self.statusHandle(status: status)
                }
            } else {
                print("Não existe match atual!")
            }
        } else {
            //Voltar para a AuthScreen
        }
    }
    
    func statusHandle(status: StatusEnum) {
        if status == .inProgress {
            performSegue(withIdentifier: "goToOnGoingSegue", sender: nil)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        rotateView(imageView: self.waitingBall)
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "goToProfileBabaSegue", sender: nil)
    }
}
