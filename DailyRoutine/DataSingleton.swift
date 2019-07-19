//
//  DataSingleton.swift
//  DailyRoutine
//
//  Created by Vivian Henning on 18/07/19.
//  Copyright © 2019 Matheus Marcos Maus. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import Firebase

protocol ValidaEmailDelegate: class {
    func onValidaEmail(valido: Bool)
}

protocol ValidaEmailSenhaDelegate: class {
    func onValidaEmailSenha(valido: Bool)
}

class DataSingleton {
    
    var validaEmailDelegate: ValidaEmailDelegate!
    var validaEmailSenhaDelegate: ValidaEmailSenhaDelegate!

    private let storedEmail = "email"
    private let storedPassword = "senha"

    static let sharedInstance = DataSingleton()
    public init() {}
    
    func validaEmail(_ email: String) {
        let this = self;
        Auth.auth().signIn(withEmail: email, password: " ") { (user, error) in
            if let error = error, (error as NSError).code == 17009 {
                DispatchQueue.main.async {
                    this.validaEmailDelegate.onValidaEmail(valido: true)
                }
            } else {
                DispatchQueue.main.async {
                    this.validaEmailDelegate.onValidaEmail(valido: false)
                }
            }
        }
        
    }
    
    func validaEmailSenha(_ email: String, _ senha: String) {
        let this = self;
        
        Auth.auth().signIn(withEmail: email, password: senha) { (user, error) in
            if error != nil {
                DispatchQueue.main.async {
                    this.validaEmailSenhaDelegate.onValidaEmailSenha(valido: false)
                }
                
            } else {
                self.setLoginDefaults(email, senha)
                DispatchQueue.main.async {
                    this.validaEmailSenhaDelegate.onValidaEmailSenha(valido: true)
                }
            }
        }
    }
    
    
    public func logout() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: self.storedEmail)
        defaults.removeObject(forKey: self.storedPassword)
    }
    
    public func setLoginDefaults(_ email: String, _ senha: String) {
        
        let defaults = UserDefaults.standard
        defaults.set(email, forKey: self.storedEmail)
        defaults.set(senha, forKey: self.storedPassword)

    }
    
    public func getLoginDefaults() -> Login {
        let defaults = UserDefaults.standard
        if let email: String = defaults.string(forKey: self.storedEmail) {
            if let senha: String = defaults.string(forKey: self.storedPassword) {
                var res = Login()
                res.email = email
                res.senha = senha
                
                return res
            }
        }
        
        return Login()
    }
    
}
