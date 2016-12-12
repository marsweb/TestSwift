//
//  ViewController.swift
//  GSettingTest2ByS3
//
//  Created by 花生 on 12/12/2016.
//  Copyright © 2016年 ihuasheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var scoreText: UITextField!
    @IBOutlet weak var saveTip: UILabel!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.nameText.text = defaults.string(forKey: "Name")
        self.scoreText.text = defaults.string(forKey: "Score")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveSetting(_ sender: Any) {
        defaults.set(self.nameText.text, forKey: "Name")
        defaults.set(self.scoreText.text, forKey: "Score")
        defaults.synchronize()
        self.saveTip.text = "Done"
    }

}

