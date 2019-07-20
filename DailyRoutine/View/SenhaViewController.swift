//
//  SenhaViewController.swift
//  DailyRoutine
//
//  Created by Matheus Marcos Maus on 05/07/19.
//  Copyright © 2019 Matheus Marcos Maus. All rights reserved.
//

import UIKit
import Firebase

class SenhaViewController: UIViewController, ValidaEmailSenhaDelegate {

    var email: String = ""

    @IBOutlet weak var labelSenha: UITextField!
    
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

        @IBAction func onBtnEntrar(_ sender: Any) {
        
        let senha = self.labelSenha.text
        
        DataSingleton.sharedInstance.validaEmailSenhaDelegate = self
        DataSingleton.sharedInstance.validaEmailSenha(email, senha!)
    }
    
    func onValidaEmailSenha(valido: Bool) {
        let senha = self.labelSenha.text
        if (!valido) {
            DataSingleton.sharedInstance.toastMessage("E-mail/senha incorretos")
        } else {
            DataSingleton.sharedInstance.setLoginDefaults(self.email, senha!)
            self.performSegue(withIdentifier: "segueMain", sender: true)
        }
    }
    
    
}
