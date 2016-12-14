//
//  ViewController.swift
//  NSCodingTest1ByS3
//
//  Created by 花生 on 14/12/2016.
//  Copyright © 2016年 ihuasheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameText1: UITextField!
    @IBOutlet weak var nameText2: UITextField!
    @IBOutlet weak var saveTip: UILabel!
    
    private let rootKey = "rootKey"
    
    func dataFilePath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let docDir = paths[0] as NSString
        return docDir.appendingPathComponent("names.archive") as String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let filePath = dataFilePath()
        if FileManager.default.fileExists(atPath: filePath) {
            // 4 steps to unarchive file
            let data = NSData(contentsOfFile: filePath)!
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data as Data)
            let names = unarchiver.decodeObject(forKey: rootKey) as! Names
            unarchiver.finishDecoding()
            
            if let newNames = names.names {
                nameText1.text = newNames[0]
                nameText2.text = newNames[1]
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveNames(_ sender: Any) {
        let filePath = dataFilePath()
        let array = [nameText1.text!, nameText2.text!]
        let names = Names()
        names.names = array
        // 5 steps to archive file
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(names, forKey: rootKey)
        archiver.finishEncoding()
        data.write(toFile: filePath, atomically: true)
        
        saveTip.text = "Done"
    }


}

