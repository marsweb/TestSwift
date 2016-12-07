//
//  ViewController.swift
//  GNavTestByS3
//
//  Created by 花生 on 7/12/2016.
//  Copyright © 2016年 ihuasheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CHANGE" {
            let newController = segue.destination as! ChangeNameController
            newController.newName = self.nameLabel.text!
            newController.delegate = self
        }
    }
}

