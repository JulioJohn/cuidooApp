//
//  FaqViewController.swift
//  CuidooApp
//
//  Created by Victoria Andressa S. M. Faria on 25/11/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import UIKit

class FaqViewController: UIViewController {
    
    @IBOutlet weak var faqTableView: UITableView!
    
    var faqs: [FaqEntity] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.faqTableView.delegate = self
        self.faqTableView.dataSource  = self
        
        
        faqTableView.register(FaqTableViewCell.nib, forCellReuseIdentifier: FaqTableViewCell.reuseIdentifier)
        
        faqs = [
            FaqEntity(title: "Como o Cuidoo funciona?", textBody: "O Cuidoo é uma plataforma que une mães a cuidadoras de crianças. A mãe pode chamar uma babá, com confiança, no momento de necessidade, sabendo quando pagará pelo serviço e tendo como referência a avaliação de outras mães antes de confirmar a solicitação."),
            FaqEntity(title: "Como me torno cuidadora?", textBody: "Atualmente permitimos apenas o cadastro de cuidadoras voluntárias indicadas. Tem interesse em ajudar mães que precisam? Entre em contato com a gente para saber mais."),
            FaqEntity(title: "Quem são as voluntárias?", textBody: "São alunas das áreas de pedagogia, enfermagem e psicologia, que possuem indicação e experiência cuidando de crianças, estando dispostas a ajudar mães que não tem com quem deixar seus filhos.")
        ]
        
    }
    
} // end class FaqViewController

extension FaqViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return faqs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newCell = tableView.dequeueReusableCell(withIdentifier: FaqTableViewCell.reuseIdentifier) as? FaqTableViewCell
        
        guard let cell = newCell else { return UITableViewCell() }
        cell.configure(entity: faqs[indexPath.row])
        return cell
    }
    
    
} // end extension FaqViewController: UITableViewDataSource, UITableViewDelegate
