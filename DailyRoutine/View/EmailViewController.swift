//
//  EmailViewController.swift
//  DailyRoutine
//
//  Created by Matheus Marcos Maus on 05/07/19.
//  Copyright © 2019 Matheus Marcos Maus. All rights reserved.
//

import UIKit

class EmailViewController: UIViewController, ValidaEmailDelegate {

    @IBOutlet weak var labelEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
 
    override func viewWillAppear(_ animated: Bool) {
        setGradientBackground()
        super.viewWillAppear(animated)
    }
    

    
    @IBAction func onBtnNext(_ sender: Any) {
        let email = self.labelEmail.text
        
        if ( email?.count == 0 ) {
            DataSingleton.sharedInstance.toastMessage("Informe o e-mail")
            return
        }

        DataSingleton.sharedInstance.validaEmailDelegate = self
        DataSingleton.sharedInstance.validaEmail(email!)
    }
    
    func onValidaEmail(valido: Bool, emailValido: Bool) {
        if (valido == true && emailValido == true) {
            self.performSegue(withIdentifier: "segueSenha", sender: true)
        } else if (valido == false && emailValido == true) {
            self.performSegue(withIdentifier: "segueNovaConta", sender: true)
        } else {
            DataSingleton.sharedInstance.toastMessage("E-mail inválido")
        }
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let email = self.labelEmail.text
        if segue.destination is SenhaViewController
        {
            let vc = segue.destination as? SenhaViewController
            vc?.email = email!
        } else if segue.destination is CriarContaViewController {
            let vc = segue.destination as? CriarContaViewController
            vc?.email = email!
        }
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

}
