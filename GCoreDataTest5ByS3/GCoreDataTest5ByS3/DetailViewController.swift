//
//  DetailViewController.swift
//  GCoreDataTest5ByS3
//
//  Created by 花生 on 21/12/2016.
//  Copyright © 2016年 ihuasheng. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var ageText: UITextField!
    @IBOutlet weak var saveTips: UILabel!
    
    var isNew = true
    var idValue = ""
    var nameValue = ""
    var ageValue: Int16 = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        nameText.text = nameValue
        ageText.text = String(ageValue)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveStudent(_ sender: Any) {
        let stuName = nameText.text
        let stuAge = Int16(ageText.text!)
        let errorText = "" //var
        // TODO Check Input
        // Add or modify
        var resultFlag = false
        if isNew {
            resultFlag = DataUtil.addStudent(sNo: idValue, sName: stuName!, sAge: stuAge!)
        } else {
            resultFlag = DataUtil.modifyStudentInfo(sNo: idValue, sName: stuName!, sAge: stuAge!)
        }
        if resultFlag {
            // A success alert
            var tempText = "Modify Success!"
            if isNew {
                tempText = "Add Success!"
            }
            let alert = UIAlertController(title: "Success", message: tempText, preferredStyle: .alert)
            let alertBtn = UIAlertAction(title: "OK", style: .default, handler: { (alertAction: UIAlertAction) in
                _ = self.navigationController?.popViewController(animated: true)
            })
            alert.addAction(alertBtn)
            self.present(alert, animated: true, completion: nil)
        } else {
            saveTips.text = errorText
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
