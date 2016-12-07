//
//  ChangeNameController.swift
//  GNavTestByS3
//
//  Created by 花生 on 7/12/2016.
//  Copyright © 2016年 ihuasheng. All rights reserved.
//

import UIKit

class ChangeNameController: UIViewController {
    
    var newName: String = ""
    weak var delegate: ViewController?

    @IBOutlet weak var nameText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameText.text = newName
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveName(_ sender: Any) {
        if nameText.text != nil {
            newName = nameText.text!
        }
        delegate?.nameLabel.text = newName
        //get this return value by _ could avoid a warning
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
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
