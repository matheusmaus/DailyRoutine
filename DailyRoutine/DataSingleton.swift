//
//  DataSingleton.swift
//  DailyRoutine
//
//  Created by Matheus Marcos Maus on 18/07/19.
//  Copyright © 2019 Matheus Marcos Maus. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import Firebase

protocol ValidaEmailDelegate: class {
    func onValidaEmail(valido: Bool, emailValido: Bool)
}

protocol ValidaEmailSenhaDelegate: class {
    func onValidaEmailSenha(valido: Bool)
}

protocol AddTaskDelegate: class {
    func onAddTask(success: Bool)
}

protocol ReadTasksDelegate: class {
    func onReadTasks(success: Bool, tarefas: Array<Tarefa>)
}

class DataSingleton {
    
    var validaEmailDelegate: ValidaEmailDelegate!
    var validaEmailSenhaDelegate: ValidaEmailSenhaDelegate!
    var addTaskDelegate: AddTaskDelegate!
    var readTasksDelegate: ReadTasksDelegate!
    
    private let storedEmail = "email"
    private let storedPassword = "senha"

    static let sharedInstance = DataSingleton()
    public init() {}
    
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
    
    func validaEmail(_ email: String) {
        let this = self;
        Auth.auth().signIn(withEmail: email, password: " ") { (user, error) in
            if let error = error, (error as NSError).code == 17009 {
                DispatchQueue.main.async {
                    this.validaEmailDelegate.onValidaEmail(valido: true, emailValido: true)
                }
            }
            if let error = error, (error as NSError).code == 17008 {
                DispatchQueue.main.async {
                    this.validaEmailDelegate.onValidaEmail(valido: false, emailValido: false)
                }
            }
            else {
                DispatchQueue.main.async {
                    this.validaEmailDelegate.onValidaEmail(valido: false, emailValido: true)
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
                let defaults = UserDefaults.standard
                defaults.set(user?.user.uid, forKey: "uid")
                
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
    
    func retornaTarefas() {

        var tarefas = Array<Tarefa>()
        
        let db = Firestore.firestore()
        db.collection("DailyRoutine").getDocuments {(snapshot, err) in
            if let err = err {
                self.readTasksDelegate.onReadTasks(success: false, tarefas: Array<Tarefa>())
            } else {
                
                for document in snapshot!.documents{
                    let ID = document.documentID as! String
                    let nome = document.get("nome") as! String
                    let horario = document.get("horario") as! String
                    let notas = document.get("notas") as! String

                    let tarefa = Tarefa(ID: ID, nome: nome, horario: horario, notas: notas)
                    tarefas.append(tarefa)
                }
                
                self.readTasksDelegate.onReadTasks(success: true, tarefas: tarefas)
            }
        }
    }
    
    
    func adicionaTarefa(_ taskName: String, _ horario: String, _ duracao: Int, _ notas: String) {
        
        let db = Firestore.firestore()
        
        db.collection("DailyRoutine").addDocument(data: [
            
            "nome": taskName,
            "horario": horario,
            "periodicidade": [true,true,true,true,true,true,true],
            "alerta": 1,
            "duracao": duracao,
            "notas": notas
        ]) {
            
            (error:Error?) in
            if error != nil {
                self.addTaskDelegate.onAddTask(success: false)
            } else {
                self.addTaskDelegate.onAddTask(success: true)

            }
        }
        
        
        
        
    }
    
    
    
    
}
