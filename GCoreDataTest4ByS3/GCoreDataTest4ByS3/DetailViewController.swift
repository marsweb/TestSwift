//
//  DetailViewController.swift
//  GCoreDataTest4ByS3
//
//  Created by 花生 on 20/12/2016.
//  Copyright © 2016年 ihuasheng. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var ageText: UITextField!
    @IBOutlet weak var saveTips: UILabel!
    
    var studentModify: Bool = false
    var studentNo: String = ""
    var studentName: String = ""
    var studentAge: Int16 = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if studentModify {
            // Modify data
            self.title = "Modify Student"
            nameText.text = studentName
            ageText.text = String(studentAge)
        } else {
            // create data
            self.title = "New Student"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveStu(_ sender: Any) {
        let sNo = studentNo
        let sName = nameText.text!
        let sAge = Int16(ageText.text!)
        // TODO Check Data
        // Save Data
        let saveRes = DataUtil.saveData(sNo, sName: sName, sAge: sAge!)
        if saveRes == true {
            saveTips.text = "Done"
            _ = navigationController?.popViewController(animated: true)
        } else {
            saveTips.text = "System Error"
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
