//
//  DetailViewController.swift
//  GTest1ByS3
//
//  Created by 花生 on 28/12/2016.
//  Copyright © 2016年 ihuasheng. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

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
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Save", comment: "save"), style: .plain, target: self, action: #selector(saveStu))
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
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        studentPic.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        picker.dismiss(animated: true, completion: nil)
    }
    
    func saveStu() {
        // TODO Check Input
        if studentPic.image == nil || studentName.text == "" {
            let alert = UIAlertController(title: NSLocalizedString("Missing student's Info", comment: "missing student's info"), message: "", preferredStyle: .alert)
            let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: "ok"), style: .default, handler: { (_) in
                return
            })
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        } else {
            let stu: Student = Student(sNo: stuNo, sName: studentName.text!, sPic: UIImagePNGRepresentation(studentPic.image!)! as NSData)
            var resultFlag = false
            if isNew {
                resultFlag = DataUtil.createStudent(student: stu)
            } else {
                resultFlag = DataUtil.updateStudentInfo(student: stu)
            }
            if resultFlag {
                let alert = UIAlertController(title: NSLocalizedString("Successed", comment: "successed"), message: "", preferredStyle: .alert)
                let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: "ok"), style: .default, handler: { (_) in
                    _ = self.navigationController?.popViewController(animated: true)
                })
                alert.addAction(okAction)
                present(alert, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: NSLocalizedString("Failed", comment: "failed"), message: NSLocalizedString("please check your info or connect admin", comment: "please check your info or connect admin"), preferredStyle: .alert)
                let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: "ok"), style: .default, handler: nil)
                alert.addAction(okAction)
                present(alert, animated: true, completion: nil)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func changePic(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .photoLibrary
            present(picker, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: NSLocalizedString("Photo Picker Error", comment: "photo picker error"), message: NSLocalizedString("Unsupported media source", comment: "unsupported media source"), preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
    }
}

















