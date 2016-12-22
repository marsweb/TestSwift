//
//  ViewController.swift
//  GCoreDataTest6ByS3
//
//  Created by 花生 on 22/12/2016.
//  Copyright © 2016年 ihuasheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var myTableView: UITableView!
    
    private var students: [Student] = []
    private let cellID = "StudentCell"
    private let segID = "DetailSeg"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Get data
        students = DataUtil.getAllStudent()
        // Regist cell
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        // Add Nav Btn
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(goAddStudent))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Get data
        students = DataUtil.getAllStudent()
        // Refresh table view
        myTableView.reloadData()
    }
    
    func goAddStudent() {
        performSegue(withIdentifier: segID, sender: nil)
    }
    
    // Student's info summary
    private func getStudentStr(stu: Student) -> String {
        return stu.sName+" ,"+String(stu.sAge)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel?.text = getStudentStr(stu: students[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: segID, sender: students[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Delete Warning", message: "Are you sure to delete this info", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Yes", style: .default) { _ in
            // del stu
            if DataUtil.deleteStudent(sNo: self.students[indexPath.row].sNo) {
                // del prop stu
                self.students.remove(at: indexPath.row)
                // del cell
                tableView.deleteRows(at: [indexPath], with: .top)
            }
        }
        let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        let desVC = segue.destination as! DetailViewController
        if sender == nil {
            desVC.isNew = true
            desVC.sNo = String(students.count)
        } else {
            let stu = sender as! Student
            desVC.isNew = false
            desVC.sNo = stu.sNo
            desVC.sName = stu.sName
            desVC.sAge = stu.sAge
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

