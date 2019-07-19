//
//  SenhaViewController.swift
//  DailyRoutine
//
//  Created by Matheus Marcos Maus on 05/07/19.
//  Copyright © 2019 Matheus Marcos Maus. All rights reserved.
//

import UIKit
import Firebase

class SenhaViewController: UIViewController {
    
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
        let colorTop =  UIColor(red: 255.0/255.0, green: 149.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 255.0/255.0, green: 94.0/255.0, blue: 58.0/255.0, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    

        @IBAction func onBtnEntrar(_ sender: Any) {
        
        let senha = self.labelSenha.text
        
        Auth.auth().signIn(withEmail: email, password: senha!) { (user, error) in
            if let error = error {
                print(error)
            } else {
                DataSingleton.sharedInstance.setLoginDefaults(self.email, senha!)
                self.performSegue(withIdentifier: "segueMain", sender: true)
            }
        }
    }
    
}
