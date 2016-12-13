//
//  ViewController.swift
//  GFileTest1ByS3
//
//  Created by 花生 on 13/12/2016.
//  Copyright © 2016年 ihuasheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var name1Text: UITextField!
    @IBOutlet weak var name2Text: UITextField!
    @IBOutlet weak var saveTip: UILabel!
    
    func dateFilePath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let docDir = paths[0] as NSString
        return docDir.appendingPathComponent("names.plist") as String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let filePath = dateFilePath()
        if FileManager.default.fileExists(atPath: filePath) {
            let nameArr = NSArray(contentsOfFile: filePath) as! [String]
            name1Text.text = nameArr[0]
            name2Text.text = nameArr[1]
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveNames(_ sender: Any) {
        let filePath = dateFilePath()
        let nameArr = [name1Text.text!, name2Text.text!] as NSArray
        nameArr.write(toFile: filePath, atomically: true)
        saveTip.text = "Done"
    }


}

