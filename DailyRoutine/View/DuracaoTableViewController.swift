//
//  DuracaoTableViewController.swift
//  DailyRoutine
//
//  Created by Matheus Marcos Maus on 12/07/19.
//  Copyright © 2019 Matheus Marcos Maus. All rights reserved.
//

import UIKit

class DuracaoTableViewController: UITableViewController {
    
    var duracao: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "< Voltar", style: UIBarButtonItem.Style.plain, target: self, action: #selector(DuracaoTableViewController.back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
    }
    
    @objc func back(sender: UIBarButtonItem) {       

        let defaults = UserDefaults.standard
        defaults.set(duracao, forKey: "duracao")
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
            
            let section = indexPath.section
            let item = indexPath.item

            if ( section == 0 ) {
                duracao = 0;
            } else {
                if ( item == 0 ) {
                    duracao = 1;
                } else if ( item == 1 ) {
                    duracao = 2;
                } else if ( item == 2 ) {
                    duracao = 3;
                } else if ( item == 3 ) {
                    duracao = 4;
                } else if ( item == 4 ) {
                    duracao = 5;
                }
            }

        }
    } 


}
