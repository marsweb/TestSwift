//
//  DetailViewController.swift
//  GCoreDataTest6ByS3
//
//  Created by 花生 on 22/12/2016.
//  Copyright © 2016年 ihuasheng. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var ageText: UITextField!
    @IBOutlet weak var saveTips: UILabel!
    
    var isNew = true
    var sNo = ""
    var sName = ""
    var sAge: Int16 = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameText.text = sName
        self.ageText.text = String(sAge)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveStudent(_ sender: UIButton) {
        let stu = Student(sNo: sNo, sName: nameText.text!, sAge: Int16(ageText.text!)!)
        var opresult = false
        var opType = "Add Student"
        if isNew {
            opresult = DataUtil.addStudent(student: stu)
        } else {
            opType = "Modify Student"
            opresult = DataUtil.modifyStudent(student: stu)
        }
        if opresult {
            let alert = UIAlertController(title: opType, message: opType + " Success", preferredStyle: .alert)
            let okBtn = UIAlertAction(title: "OK", style: .default, handler: { _ in
                _ = self.navigationController?.popViewController(animated: true)
            })
            alert.addAction(okBtn)
            present(alert, animated: true, completion: nil)
        } else {
            self.saveTips.text = "Some Error Happened!"
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
