//
//  SearchViewController.swift
//  CuidooApp
//
//  Created by Victor Toon de Araújo on 11/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchTableView: UITableView!
    //essa é a tableview grande da tela
    @IBOutlet weak var searchButton: UIButton!
    
    private var entities: [BabySitterEntity]?
    
    @IBAction func goToSearchUnwind(_ segue : UIStoryboardSegue){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
        self.navigationController?.navigationBar.tintColor = .cuidooPink
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 280, height: 28))
        imageView.contentMode = .scaleAspectFit
          
        // 4
        let image = UIImage(named: "CuidooLogo")
        imageView.image = image
          
        // 5
        navigationItem.titleView = imageView
        
        self.searchButton.layer.cornerRadius = 20
        searchTableView.delegate = self
        searchTableView.dataSource = self
        
        searchTableView.register(UINib(nibName: "BabySitterCell", bundle: nil), forCellReuseIdentifier: "babySitterCell")
        searchTableView.register(UINib(nibName: "InfoCell", bundle: nil), forCellReuseIdentifier: "infoCell")
        searchTableView.register(UINib(nibName: "MapCell", bundle: nil), forCellReuseIdentifier:
            "mapCell")
        searchTableView.register(UINib(nibName: "AddDetailsCell", bundle: nil), forCellReuseIdentifier: "addDetailsCell")
        
        searchTableView.tableFooterView = UIView()
        searchTableView.estimatedRowHeight = 200
        searchTableView.rowHeight = UITableView.automaticDimension
        searchTableView.allowsMultipleSelection = false
        
        entities = [BabySitterEntity(title: "Cuidadora voluntária", time: "12 minutos de você", value: "R$0,00"),
                    BabySitterEntity(title: "Cuidadora mãe", time: "12 minutos de você", value: "R$63,00"),
                    BabySitterEntity(title: "Cuidadora profissional", time: "12 minutos de você", value: "R$84,00")]
    }
    
    @IBAction func searchButton(_ sender: Any) {
        self.performSegue(withIdentifier: "goToWaitingScene", sender: nil)
    }
    
    func noBabySitterAlert() {
        let alert = UIAlertController(title: "Ops", message: "Não temos nenhuma cuidadora disponível na sua região no momento.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
    
}

extension SearchViewController: InfoCellDelegate {
    func didClickExpand() {
        searchTableView.beginUpdates()
        searchTableView.endUpdates()
    }
}

extension SearchViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let newCell = searchTableView.dequeueReusableCell(withIdentifier: "mapCell", for: indexPath) as? MapCell
            newCell?.configure(delegate: self)
            
            guard let cell = newCell else { return UITableViewCell()}
            return cell
        case 1:
            let newCell = searchTableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as? InfoCell
            newCell?.configure(delegate: self)
            
            guard let cell = newCell else { return UITableViewCell() }
            return cell
        case 2:
            let newCell = searchTableView.dequeueReusableCell(withIdentifier: "addDetailsCell", for: indexPath) as? AddDetailsCell
            newCell?.configure(delegate: self)
            
            guard let cell = newCell else { return UITableViewCell() }
            return cell
        default:
            let newCell = searchTableView.dequeueReusableCell(withIdentifier: "babySitterCell", for: indexPath) as?  BabySitterCell
            if let entities = entities {
                newCell?.configure(entity: entities[indexPath.row])
            }
            
            guard let cell = newCell else { return UITableViewCell() }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension SearchViewController: UITableViewDelegate{
    
}

