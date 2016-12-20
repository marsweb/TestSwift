//
//  ViewController.swift
//  GCoreDataTest4ByS3
//
//  Created by 花生 on 20/12/2016.
//  Copyright © 2016年 ihuasheng. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var myTableView: UITableView!
    
    private var students: [NSManagedObject] = []
    private let cellId = "CELL"
    private let detailSeg = "DetailSeg"

    func goAddStu() {
        self.performSegue(withIdentifier: detailSeg, sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Get data
        students = DataUtil.getAllStudents()
        // Regist cell
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        // Add nav's right button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.plain, target: self, action: #selector(goAddStu))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        students = DataUtil.getAllStudents()
        myTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let sName = students[indexPath.row].value(forKey: DataUtil.sNameColumn) as! String
        let sAge = String(students[indexPath.row].value(forKey: DataUtil.sAgeColumn) as! Int16)
        let cellValue = sName + "," + sAge
        cell.textLabel?.text = cellValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: detailSeg, sender: students[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // Delete data
        let sNo = students[indexPath.row].value(forKey: DataUtil.sNoColumn) as! String
        let delFlag = DataUtil.delData(sNo)
        if delFlag {
            // Delete cell
            students.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.top)
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let desVC = segue.destination as! DetailViewController
        if sender == nil {
            // Create new student
            desVC.studentModify = false
            desVC.studentNo = String(students.count)
            print("Add New Go")
        } else {
            // Modify student
            let sendStu = sender as! NSManagedObject
            desVC.studentModify = true
            desVC.studentNo = sendStu.value(forKey: DataUtil.sNoColumn) as! String
            desVC.studentName = sendStu.value(forKey: DataUtil.sNameColumn) as! String
            desVC.studentAge = sendStu.value(forKey: DataUtil.sAgeColumn) as! Int16
            print("Modify Go")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

