//
//  ConfirmMatchViewController.swift
//  CuidooApp
//
//  Created by Victor Toon de Araújo on 04/12/19.
//  Copyright © 2019 Júlio John Tavares Ramos. All rights reserved.
//

import UIKit

class ConfirmMatchViewController: UIViewController {
    
    @IBOutlet weak var babySitterConfirmMatchView: babySitterConfirmMatchView!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var deniedButton: UIButton!
    
    @IBOutlet weak var timerView: UIView!
    var myTimer: Timer?
    
    override func viewDidAppear(_ animated: Bool) {
        self.myTimer =  Timer.scheduledTimer(withTimeInterval: 10.0, repeats: false, block: { (timer) in
            //Deletar o match aqui
            self.performSegue(withIdentifier: "goToProfileBabaSegue", sender: nil)
        })
        drawTimer(myView: timerView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        acceptButton.layer.cornerRadius = 13.0
        deniedButton.layer.cornerRadius = 13.0
        
        //Deixa a navegation bar sem a linha de baixo
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
        self.navigationController?.navigationBar.tintColor = .cuidooPink
        
        
        if LoggedUser.shared.userIsLogged() {
            if let id = LoggedUser.shared.actualMatchID {
                //Observa se ouve mudança de status!
                MatchServices.addListener(matchId: id) { (status) in
                    self.handleStatus(status: status)
                }
            }
        } else {
            print("O usuário não existe")
        }
    }
    
    @IBAction func acceptButton(_ sender: Any) {
        self.acceptButton.isEnabled = false
        myTimer?.invalidate()
        MatchServices.changeMatchStatus {
            self.acceptButton.isEnabled = true
            self.performSegue(withIdentifier: "goToWaitingBabysitterSegue", sender: nil)
        }
    }
    
    @IBAction func denniedButton(_ sender: Any) {
        self.performSegue(withIdentifier: "goToProfileBabaSegue", sender: nil)
    }
    
    func handleStatus(status: StatusEnum) {
        if status == .available {
            self.performSegue(withIdentifier: "goToProfileBabaSegue", sender: nil)
        }
    }
    
}

extension ConfirmMatchViewController {
    func drawTimer(myView: UIView) {
        let theView = myView.frame
        
        //Linha cinza
        let pathCinza = UIBezierPath()
        pathCinza.move(to: CGPoint(x: 0, y: 0))
        pathCinza.addLine(to: (CGPoint(x: theView.width, y: 0)))
        
        //Shape layer da linha cinza
        let shapeLayerCinza = CAShapeLayer()
        shapeLayerCinza.fillColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1).cgColor
        shapeLayerCinza.strokeColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1).cgColor
        shapeLayerCinza.lineWidth = 4
        shapeLayerCinza.path = pathCinza.cgPath
        
        //Adiciono linha cinza
        myView.layer.addSublayer(shapeLayerCinza)
        
        //Linha vermelha
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: theView.width, y: 0))

        //Shape layer da linha vermelha
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = #colorLiteral(red: 1, green: 0.3921568627, blue: 0.3921568627, alpha: 1).cgColor
        shapeLayer.strokeColor = #colorLiteral(red: 1, green: 0.3921568627, blue: 0.3921568627, alpha: 1).cgColor
        shapeLayer.lineWidth = 4
        shapeLayer.path = path.cgPath

        //Animação do Shape
        myView.layer.addSublayer(shapeLayer)
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.duration = 10.0
        shapeLayer.add(animation, forKey: "MyAnimation")
    }
}
