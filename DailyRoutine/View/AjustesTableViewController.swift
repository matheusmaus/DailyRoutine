//
//  DurationTableViewController.swift
//  DailyRoutine
//
//  Created by Matheus Marcos Maus on 18/07/19.
//  Copyright © 2019 Matheus Marcos Maus. All rights reserved.
//

import UIKit

class AjustesTableViewController: UITableViewController {

    @IBOutlet weak var timePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "< Voltar", style: UIBarButtonItem.Style.plain, target: self, action: #selector(AjustesTableViewController.back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
    }
    
    @objc func back(sender: UIBarButtonItem) {

        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "HH:mm"
        let dataText = dateformatter.string(from: self.timePicker!.date)

        let defaults = UserDefaults.standard
        defaults.set(dataText, forKey: "horario")
        
        _ = navigationController?.popViewController(animated: true)
    }
    
}
