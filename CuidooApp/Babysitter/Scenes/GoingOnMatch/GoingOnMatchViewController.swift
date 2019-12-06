//
//  GoingOnMatchViewController.swift
//  CuidooApp
//
//  Created by Júlio John Tavares Ramos on 04/12/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import UIKit

class GoingOnMatchViewController: UIViewController {
    
    @IBOutlet var babysitterGoingOnMatchView: GoingOnMatchView!
    
    let matchId: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if LoggedUser.shared.userIsLogged() {
            if let id = LoggedUser.shared.actualMatchID {
                MatchServices.addListener(matchId: id) { (status) in
                    self.handleStatus(status: status)
                }
            }
        } else {
            print("Usuario esta deslogado!")
            //Usuario deslogado!
        }
    }
    
    func handleStatus(status: StatusEnum) {
        if status == .finished {
            performSegue(withIdentifier: "goToSearchSegue", sender: nil)
        }
    }

    @IBAction func chatButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "goToChatSegue", sender: nil)
    }
    
    @IBAction func finalizeButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "goToSearchSegue", sender: nil)
    }
}

extension GoingOnMatchViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToChatSegue" {
            if let vc = segue.destination as? ChatViewController {
                vc.matchId = matchId
            }
        }
    }
}
