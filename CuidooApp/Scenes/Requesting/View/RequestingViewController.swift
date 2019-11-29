//
//  RequestingViewController.swift
//  CuidooApp
//
//  Created by Victoria Andressa S. M. Faria on 27/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import UIKit

class RequestingViewController: UIViewController {

    
    @IBOutlet weak var requestingTableView: UITableView!
    
    var entityDataPicture: HistoryEntity?
    var entityEvaluation: EvaluationEntity?
    var entityAbout: aboutBabySitterEntity?
    var entityRecommendation: [HistoryEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestingTableView.delegate =  self
        requestingTableView.dataSource = self

        requestingTableView.register(RecommendationCell.nib, forCellReuseIdentifier: RecommendationCell.reuseIdentifier)
        
        requestingTableView.register(AboutCell.nib, forCellReuseIdentifier: AboutCell.reuseIdentifier)
        
        requestingTableView.register(EvaluationCell.nib, forCellReuseIdentifier: EvaluationCell.reuseIdentifier)
        
        requestingTableView.register(DataPictureCell.nib, forCellReuseIdentifier: DataPictureCell.reuseIdentifier)

       
        requestingTableView.tableFooterView = UIView()
        requestingTableView.estimatedRowHeight = 200
        requestingTableView.rowHeight = UITableView.automaticDimension
        requestingTableView.allowsMultipleSelection = false
        
        // ---------------------------------------------------------
        
        //sessão 1
        entityDataPicture =
            HistoryEntity(name: "Barbara", timestamp: nil, value: nil, favoriteHeart: nil, rating: nil, age: "34", ocupation: "Enfermeira")
        
        //sessão2
        entityEvaluation = EvaluationEntity(jobs: "28", evaluation: "4.5", experience: "2 anos")
        
        //sessão 3
        entityAbout = aboutBabySitterEntity(aboutBabySitter: "Moro com minha mãe e estudo há dois anos, preciso de uma renda extra e como amo crianças resolvi entrar no app :)")
        
        //sessão 4
        entityRecommendation = [ HistoryEntity(name: "Camila", timestamp: Date(), rating: 4, textEvaluation: "Minha filha amou a Claudia, muito cuidadosa e brincalhona."),
                                 HistoryEntity(name: "Roberta", timestamp: Date(), rating: 3, textEvaluation: "Minha filha amou a Claudia, muito cuidadosa e brincalhona."),
                                 HistoryEntity(name: "Aline", timestamp: Date(), rating: 4, textEvaluation: "Minha filha amou a Claudia, muito cuidadosa e brincalhona."),
                                 
        ]
        
        
        
    } // end vewDidLoad()
    
    
    @IBAction func chatButton(_ sender: Any) {
        
    }
    
    @IBAction func endButton(_ sender: Any) {
        MatchServices.momFinalizeMatch {
            print("Finalizou chamado!")
        }
        //O IDEAL É SÓ PULAR DEPOIS DE ALTERAR OS DADOS NO BANCO!!! LEMBRAR DISSO!!!
        self.performSegue(withIdentifier: "searchSegue", sender: nil)
    }
    
} // end class RequestingViewController

extension RequestingViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 3 ? entityRecommendation.count : 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
           return 4
       }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DataPictureCell.reuseIdentifier) as? DataPictureCell else {return UITableViewCell()}
            if let dataPicture = entityDataPicture {
                cell.configure(entity: dataPicture)
            }
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EvaluationCell.reuseIdentifier) as? EvaluationCell else {return UITableViewCell()}
            if let evaluation = entityEvaluation {
                cell.configure(entity: evaluation)
            }
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AboutCell.reuseIdentifier) as? AboutCell else {return UITableViewCell()}
            if let about = entityAbout {
                cell.configure(entity: about)
            }
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RecommendationCell.reuseIdentifier) as? RecommendationCell else {return UITableViewCell()}
            cell.configure(entity: entityRecommendation[indexPath.row])
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
} // end extension RequestingViewController: UITableViewDataSource, UITableViewDelegate
