//
//  ViewController.swift
//  DailyRoutine
//
//  Created by Matheus Marcos Maus on 21/05/19.
//  Copyright © 2019 Matheus Marcos Maus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "Meu Dia"
        label.font = UIFont.boldSystemFont(ofSize: 24.0)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
        
    // Swipe for delete
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // handle delete (by removing the data from your array and updating the tableview)
        }
    }
    
    
    // Customize Header TableView
    
//    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let view = UIView(frame: CGRect((x:0,y:0,tableView.frame.size.width,:w,height:18))
//        let label = UILabel(frame: CGRect((x:10,y:5,tableView.frame.size.width,:w,height:18)),
//                            label.font = UIFont.systemFont(ofSize: 14),
//        label.text = list.objectAtIndex(IndexPath.row) as! String
//        view.addSubview(label)
//        view.backgroundColor = UIColor.gray // Set your background color
//
//        return view
//    }
    
    // Customize height Row TableView
    
//    override func tableView(_ tableView: UITableView,
//                            heightForRowAt indexPath: IndexPath) -> CGFloat {
//        // Make the first row larger to accommodate a custom cell.
//        if indexPath.row == 0 {
//            return 80
//        }
//
//        // Use the default size for all other rows.
//        return UITableView.automaticDimension
//    }


}



