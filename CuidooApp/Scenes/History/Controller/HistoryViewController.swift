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
    
    var histories:[HistoryEntity] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        self.historyTableView.delegate = self
        self.historyTableView.dataSource = self
        
          historyTableView.register(UINib(nibName: "HistoryCell", bundle: nil), forCellReuseIdentifier: "HistoryCellIdentifier")
        
        MatchServices.updateMatchHistory { (matchs) in
            OperationQueue.main.addOperation {
                for i in 0 ... matchs.count - 1 {
                    self.histories.append(HistoryEntity(name: "Fulana", timestamp: matchs[i].date, value: matchs[i].price, favoriteHeart: false, rating: Int(matchs[i].avaliation)))
                }
                self.historyTableView.reloadData()
            }
        }
        
//        histories =
//               [ HistoryEntity(name: "Renata", timestamp: Date(), value: 23.00, favoriteHeart: false, rating: 4),
//                 HistoryEntity(name: "Maria", timestamp: Date(), value: 12.90, favoriteHeart: false, rating: 3),
//                 HistoryEntity(name: "Cláudia", timestamp: Date(), value: 00.00, favoriteHeart: true, rating: 1)
//               ]
    }

} // end class HistoryViewController

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
    
    
} // end extension HistoryViewController: UITableViewDataSource, UITableViewDelegate

