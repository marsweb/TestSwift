//
//  ViewController.swift
//  GFileTest2ByS3
//
//  Created by 花生 on 25/12/2016.
//  Copyright © 2016年 ihuasheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var item1Text: UITextField!
    @IBOutlet weak var item2Text: UITextField!
    
    private let defaultFileName = "itemList.plist"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let items = FileUtil.getArrayFromDocument(fileName: defaultFileName)
        if items.count == 2 {
            item1Text.text = items[0]
            item2Text.text = items[1]
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func saveItems(_ sender: Any) {
        let saveArr = [item1Text.text, item2Text.text]
        if FileUtil.saveArrayToDocument(arr: saveArr as NSArray, fileName: defaultFileName) {
            let alert = UIAlertController(title: "Save", message: "Save Success", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
}

