//
//  EmailViewController.swift
//  DailyRoutine
//
//  Created by Matheus Marcos Maus on 05/07/19.
//  Copyright © 2019 Matheus Marcos Maus. All rights reserved.
//

import UIKit
import CoreData
import Firebase

class EmailViewController: UIViewController {
    
    
    @IBOutlet weak var labelEmail: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
 
    override func viewWillAppear(_ animated: Bool) {
        setGradientBackground()
        super.viewWillAppear(animated)
    }
    
    func toastMessage(_ message: String){
        guard let window = UIApplication.shared.keyWindow else {return}
        let messageLbl = UILabel()
        messageLbl.text = message
        messageLbl.textAlignment = .center
        messageLbl.font = UIFont.systemFont(ofSize: 12)
        messageLbl.textColor = .white
        messageLbl.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        let textSize:CGSize = messageLbl.intrinsicContentSize
        let labelWidth = min(textSize.width, window.frame.width - 40)
        
        messageLbl.frame = CGRect(x: 20, y: window.frame.height - 90, width: labelWidth + 30, height: textSize.height + 20)
        messageLbl.center.x = window.center.x
        messageLbl.layer.cornerRadius = messageLbl.frame.height/2
        messageLbl.layer.masksToBounds = true
        window.addSubview(messageLbl)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            UIView.animate(withDuration: 1, animations: {
                messageLbl.alpha = 0
            }) { (_) in
                messageLbl.removeFromSuperview()
            }
        }
    }
    
    @IBAction func onBtnNext(_ sender: Any) {
        let email = self.labelEmail.text
        
        if ( email?.count == 0 ) {
            self.toastMessage("Informe o e-mail")
            return
        }
        
        Auth.auth().signIn(withEmail: email!, password: " ") { (user, error) in
            if let error = error, (error as NSError).code == 17009 {
                self.performSegue(withIdentifier: "segueSenha", sender: true)
            } else {
                self.performSegue(withIdentifier: "segueNovaConta", sender: true)
            }
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
        let colorTop =  UIColor(red: 255.0/255.0, green: 149.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 255.0/255.0, green: 94.0/255.0, blue: 58.0/255.0, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }

}
