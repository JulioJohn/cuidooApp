//
//  WaitingViewController.swift
//  CuidooApp
//
//  Created by Júlio John Tavares Ramos on 02/12/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import UIKit

class WaitingViewController: UIViewController {
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var waitingBall: UIImageView!
    
//    weak var delegate: WaitingViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.cancelButton.layer.cornerRadius = 13.0
        
        MatchServices.tryMatchWithBabysitter { (match, error) in
            if let error = error {
                if error == .thisMatchIsNotAvailable {
                    //Resolve dentro da função mesmo!
                }
            } else {
                if let matche = match {
                    //Listener que verifica se o estado atual mudou!
                    MatchServices.addListener(matchId: matche.documentId) { (status) in
                        LoggedUser.shared.actualMatchID = match?.documentId
                        self.screenHandle(status: status)
                    }
                }
            }
        }
    }
    
    func screenHandle(status: StatusEnum) {
        if status == .waitingMom {
            self.performSegue(withIdentifier: "goToRequest", sender: nil)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        rotateView(imageView: self.waitingBall)
    }

    @IBAction func cancelSearchButton(_ sender: Any) {
        performSegue(withIdentifier: "goToSearchSegue", sender: nil)
    }
}
