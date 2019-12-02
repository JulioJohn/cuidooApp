//
//  HistoryViewController.swift
//  CuidooApp
//
//  Created by Victoria Andressa S. M. Faria on 21/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
    
    @IBOutlet weak var historyTableView: UITableView!
    
    var histories: [HistoryEntity] = []
    var matchs: [MatchHistory] = []
    var idMatchClicked: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        self.historyTableView.delegate = self
        self.historyTableView.dataSource = self
        
        //Célula padrão
        historyTableView.register(UINib(nibName: "HistoryCell", bundle: nil), forCellReuseIdentifier: "HistoryCellIdentifier")
        
        //Atualizar a table view com as informacoes do Firebase
        MatchServices.updateMatchHistory { (matchs) in
            //Atualiza assicronamente
            OperationQueue.main.addOperation {
                self.matchs = matchs
                for i in 0 ... matchs.count - 1 {
                    self.histories.append(HistoryEntity(name: "Fulana", timestamp: matchs[i].date, value: matchs[i].price, favoriteHeart: false, rating: Int(matchs[i].avaliation)))
                }
                self.historyTableView.reloadData()
            }
        }
    }

}

extension HistoryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return histories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newCell = tableView.dequeueReusableCell(withIdentifier: "HistoryCellIdentifier") as? HistoryCell
        
        guard let cell = newCell else { return UITableViewCell() }
        cell.configure(entity: histories[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Pegar o chat do match correspondente a linha selecionada
        self.idMatchClicked = matchs[indexPath.row].idMatch
        performSegue(withIdentifier: "HistoryChatSegue", sender: nil)
    }
    
    //Antes de entrar no chat, atualiza o id do match que o chat está dentro
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HistoryChatSegue" {
            if let viewController = segue.destination as? ChatViewController {
                viewController.matchId = idMatchClicked
            }
        }
    }
  
}

