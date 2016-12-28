//
//  ViewController.swift
//  GTest1ByS3
//
//  Created by 花生 on 28/12/2016.
//  Copyright © 2016年 ihuasheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var students: [Student] = []
    private let cellID = "DetailSeg"
    
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        students = DataUtil.getAllStudent()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addStu))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        students = DataUtil.getAllStudent()
        myTableView.reloadData()
    }
    
    func addStu() {
        performSegue(withIdentifier: cellID, sender: nil)
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
        cell.textLabel?.text = students[indexPath.row].sName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: cellID, sender: students[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let desVC = segue.destination as! DetailViewController
        if sender == nil {
            desVC.isNew = true
            desVC.stuNo = String(students.count)
        } else {
            let stu = sender as! Student
            desVC.isNew = false
            desVC.stuNo = stu.sNo
            desVC.stuNameStr = stu.sName
            desVC.stuPicData = stu.sPic
        }
    }
}

