//
//  CriarContaViewController.swift
//  DailyRoutine
//
//  Created by Matheus Marcos Maus on 05/07/19.
//  Copyright © 2019 Matheus Marcos Maus. All rights reserved.
//

import UIKit
import Firebase

class CriarContaViewController: UIViewController {
    
    var email: String = ""
    
    @IBOutlet weak var labelPass: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setGradientBackground()
        super.viewWillAppear(animated)
    }
    
    
    func setGradientBackground() {
        let colorTop =  UIColor(red: 143.0/255.0, green: 148.0/255.0, blue: 251.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 78.0/255.0, green: 84.0/255.0, blue: 200.0/255.0, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    
    @IBAction func onBtnNewAccount(_ sender: Any) {
        
        let senha = self.labelPass.text
        
        Auth.auth().createUser(withEmail: email, password: senha!) { (user, error) in

            if let error = error, (error as NSError).code == 17008 {
                print(error)
                DataSingleton.sharedInstance.toastMessage("Email inválido")
            }
            else if let error = error {
                DataSingleton.sharedInstance.toastMessage("Erro ao criar o usuário. Talvez ele já exista no banco de dados.")
                print(error)
            }
            else {
                DataSingleton.sharedInstance.setLoginDefaults(self.email, senha!)
                self.performSegue(withIdentifier: "segueMain2", sender: true)
            }
        }

        
    }
    
    
}
