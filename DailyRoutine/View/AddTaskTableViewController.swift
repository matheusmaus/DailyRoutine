//
//  AddTaskTableViewController.swift
//  DailyRoutine
//
//  Created by Matheus Marcos Maus on 18/07/19.
//  Copyright © 2019 Matheus Marcos Maus. All rights reserved.
//

import UIKit

class AddTaskTableViewController: UITableViewController, AddTaskDelegate {

    var horario: String = ""
    var duracao: Int = 0

    @IBOutlet weak var taskName: UITextField!
    @IBOutlet weak var notes: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
    }
    
    @IBAction func onSalvar(_ sender: Any) {
        let name = self.taskName.text;
        let notas = self.notes.text ?? ""
        
        if ( name?.count == 0 ) {
            DataSingleton.sharedInstance.toastMessage("Informe o nome da tarefa")
            return
        }
        
        let defaults = UserDefaults.standard
        if let temp: String = defaults.string(forKey: "horario") {
            horario = temp;
        }
    
        if let dur: Int = Int(defaults.string(forKey: "duracao")!) {
            duracao = dur;
        }
        
        if ( horario.count == 0 ) {
            DataSingleton.sharedInstance.toastMessage("Selecione um horário para sua tarefa clicando em ajustes")
            return
        }
        
        DataSingleton.sharedInstance.addTaskDelegate = self
        DataSingleton.sharedInstance.adicionaTarefa(name!, horario, duracao, notas)
    }
    
    func onAddTask(success: Bool) {
        if (success == true) {
            DataSingleton.sharedInstance.toastMessage("Tarefa adicionada com sucesso!")
            let defaults = UserDefaults.standard
            defaults.removeObject(forKey: "duracao")
            defaults.removeObject(forKey: "horario")
            self.horario = ""
            self.duracao = 0
        } else {
            DataSingleton.sharedInstance.toastMessage("Ocorreu um erro ao adicionar tarefa")
        }
    }
    
    @IBAction func onCancelar(_ sender: Any) {
        
        
        
    }
    
    


}
