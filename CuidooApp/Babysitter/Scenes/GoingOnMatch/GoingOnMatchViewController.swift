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
    
    @IBOutlet weak var finalizeButton: UIButton!
    @IBOutlet weak var reportButton: UIButton!
    
    let matchId: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Configurações iniciais
        self.finalizeButton.layer.cornerRadius = 13.0
        self.reportButton.layer.cornerRadius = 13.0
        if let nav = navigationController {
            removeNavegationBarLine(nav: nav)
        } else {
            print("Não foi possível retirar a linha!")
        }
        
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
    @IBAction func cancelAction(_ sender: Any) {
        //DELETAR O MATCH ANTES
        cancelBabySitterAlert()
    }
    
    func handleStatus(status: StatusEnum) {
        if status == .finished {
            performSegue(withIdentifier: "goToProfileBaba", sender: nil)
        }
    }

    @IBAction func chatButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "goToChatSegue", sender: nil)
    }
    
    @IBAction func finalizeButtonAction(_ sender: Any) {
        print("Finalizou o match!")
        performSegue(withIdentifier: "goToProfileBaba", sender: nil)
    }
}

extension GoingOnMatchViewController {
    func cancelBabySitterAlert() {
        let alert = UIAlertController(title: "Confirmar cancelamento?", message: "Ao cancelar o chamado você perderá acesso aos dados da mãe.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Sim", style: .default, handler: { (action) in
            self.performSegue(withIdentifier: "goToProfileBaba", sender: nil)
        }))
        alert.addAction(UIAlertAction(title: "Não", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToChatSegue" {
            if let vc = segue.destination as? ChatViewController {
                vc.matchId = matchId
            }
        }
    }
    
    func removeNavegationBarLine(nav: UINavigationController) {
        nav.navigationBar.barTintColor = .white
        nav.navigationBar.shadowImage = UIImage()
        nav.navigationBar.layoutIfNeeded()
        nav.navigationBar.tintColor = .cuidooPink
    }
    
}
