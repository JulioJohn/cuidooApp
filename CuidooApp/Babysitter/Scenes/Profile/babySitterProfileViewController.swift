//
//  babySitterProfileViewController.swift
//  CuidooApp
//
//  Created by Victor Toon de Araújo on 29/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import UIKit

class babySitterProfileViewController: UIViewController {

    @IBOutlet weak var babySitterProfileTableView: UITableView!
    @IBOutlet weak var startJobButtonOutlet: UIButton!
    @IBOutlet weak var babySItterImageOutlet: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startJobButtonOutlet.layer.cornerRadius = 13
        babySitterProfileTableView.delegate = self
        babySitterProfileTableView.dataSource = self
    }
    
    @IBAction func startJobButtonAction(_ sender: Any) {
        //FAZER DEIXAR OFFLINE!!! E FAZER FICAR ONLINE

        if LoggedUser.shared.userIsLogged() {
            MatchServices.createMatch(idBaba: LoggedUser.shared.user!.uid)
            //Atualiza meu usuario local
            MatchServices.getUser {
                LoggedUser.shared.user!.showClass()
                //Observa se ouve mudança de status!
                MatchDAO.addListener(matchId: LoggedUser.shared.actualMatch!.documentId) { (error) in
                    print("Chamar a tela aqui!")
                }
            }
        } else {
            print("O usuário não existe")
        }
    }

}

extension babySitterProfileViewController: UITableViewDelegate{
    
}

extension babySitterProfileViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
