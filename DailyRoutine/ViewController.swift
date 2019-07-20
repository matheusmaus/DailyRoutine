//
//  ViewController.swift
//  DailyRoutine
//
//  Created by Matheus Marcos Maus on 21/05/19.
//  Copyright © 2019 Matheus Marcos Maus. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ReadTasksDelegate {

    var tarefas: Array<Tarefa> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataSingleton.sharedInstance.readTasksDelegate = self
        DataSingleton.sharedInstance.retornaTarefas();
        
        let switchButton = UIButton(type: .custom)
        switchButton.isSelected = true
        switchButton.setImage(UIImage(named: "on-switch"), for: .selected)
        switchButton.setImage(UIImage(named: "off-switch"), for: [])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "Meu Dia"
        label.font = UIFont.boldSystemFont(ofSize: 24.0)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // handle delete (by removing the data from your array and updating the tableview)
        }
    }
    
    
    @IBAction func onAddTask(_ sender: Any) {
        performSegue(withIdentifier: "segueTask", sender: true)
    }
    
    func onReadTasks(success: Bool, tarefas: Array<Tarefa>) {
        self.tarefas = tarefas
    }
    
    
}
