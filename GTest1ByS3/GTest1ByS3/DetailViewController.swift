//
//  DetailViewController.swift
//  GTest1ByS3
//
//  Created by 花生 on 28/12/2016.
//  Copyright © 2016年 ihuasheng. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var studentPic: UIImageView!
    @IBOutlet weak var studentName: UITextField!
    @IBOutlet weak var picBtn: UIButton!
    
    var stuNo: String = ""
    var stuPicData: NSData?
    var stuNameStr: String = ""
    var isNew: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        studentName.text = stuNameStr
        //navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Save", comment: "add picture"), style: .plain, target: self, action: #selector(saveStu))
        if isNew {
            self.studentName.isEnabled = true
            picBtn.setTitle(NSLocalizedString("Add Picture", comment: "add picture"), for: .normal)
            self.title = NSLocalizedString("New Student", comment: "new student")
        } else  {
            studentPic.image = UIImage(data: stuPicData as! Data)
            self.studentName.isEnabled = false
            picBtn.setTitle(NSLocalizedString("Change Picture", comment: "change picture"), for: .normal)
            self.title = NSLocalizedString("Modify Student", comment: "modify student")
        }
    }
    
    func saveStu() {
        let stu: Student = Student(sNo: stuNo, sName: studentName.text!, sPic: UIImagePNGRepresentation(studentPic.image!)! as NSData)
        var resultFlag = false
        if isNew {
            resultFlag = DataUtil.createStudent(student: stu)
        } else {
            resultFlag = DataUtil.updateStudentInfo(student: stu)
        }
        if resultFlag {
            _ = self.navigationController?.popViewController(animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func changePic(_ sender: Any) {
        
    }

}
