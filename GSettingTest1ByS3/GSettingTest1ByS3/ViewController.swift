//
//  ViewController.swift
//  GSettingTest1ByS3
//
//  Created by 花生 on 11/12/2016.
//  Copyright © 2016年 ihuasheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var scoreText: UITextField!
    @IBOutlet weak var saveTips: UILabel!
    
    private let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        nameText.text = defaults.string(forKey: "SName")
        scoreText.text = defaults.string(forKey: "SScore")
    }
    @IBAction func saveValues(_ sender: Any) {
        defaults.set(nameText.text, forKey: "SName")
        defaults.set(scoreText.text, forKey: "SScore")
        // Save Setting Values
        defaults.synchronize()
        saveTips.text = "Save Successed"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

