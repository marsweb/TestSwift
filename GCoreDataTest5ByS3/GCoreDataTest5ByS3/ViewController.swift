//
//  ViewController.swift
//  GCoreDataTest5ByS3
//
//  Created by 花生 on 21/12/2016.
//  Copyright © 2016年 ihuasheng. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var myTableView: UITableView!
    
    private var students: [NSManagedObject] = []
    
    private let cellID = "STUCELL"
    private let segID = "DetailSeg"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        students = DataUtil.getAllStudent()
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(goAddStu))
    }
    
    func goAddStu() {
        performSegue(withIdentifier: segID, sender: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        students = DataUtil.getAllStudent()
        myTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel?.text = DataUtil.getStuValueForCell(stu: students[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: segID, sender: students[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Delete Warning", message: "Are you sure to delete this info?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let sureAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
            let delID = self.students[indexPath.row].value(forKey: DataUtil.idColumn) as! String
            let delFlag = DataUtil.delStudent(sNo: delID)
            if delFlag {
                self.students.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .top)
            } else {
                print("Delete failed")
            }
        })
        alert.addAction(cancelAction)
        alert.addAction(sureAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let desVC = segue.destination as! DetailViewController
        if sender != nil {
            let stuSender = sender as! NSManagedObject
            desVC.isNew = false
            desVC.idValue = stuSender.value(forKey: DataUtil.idColumn) as! String
            desVC.nameValue = stuSender.value(forKey: DataUtil.nameColumn) as! String
            desVC.ageValue = stuSender.value(forKey: DataUtil.ageColumn) as! Int16
        } else {
            desVC.isNew = true
            desVC.idValue = String(students.count) // new id is next number of the last student's id
        }
    }

}

