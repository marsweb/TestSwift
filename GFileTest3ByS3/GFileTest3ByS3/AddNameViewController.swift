//
//  AddNameViewController.swift
//  GFileTest3ByS3
//
//  Created by 花生 on 2/1/2017.
//  Copyright © 2017年 ihuasheng. All rights reserved.
//

import UIKit

class AddNameViewController: UIViewController {

    @IBOutlet weak var nameText: UITextField!
    private let fileName: String = "names.plist"
    
    var nameList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addName(_ sender: Any) {
        // TODO Check data
        let newName: String = self.nameText.text!
        nameList.append(newName)
        _ = FileTools.saveArrayToFile(arr: nameList as NSArray, fileName: fileName)
        _ = navigationController?.popViewController(animated: true)
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
