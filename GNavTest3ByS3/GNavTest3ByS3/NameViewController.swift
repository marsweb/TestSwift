//
//  NameViewController.swift
//  GNavTest3ByS3
//
//  Created by 花生 on 10/12/2016.
//  Copyright © 2016年 ihuasheng. All rights reserved.
//

import UIKit

class NameViewController: UIViewController {

    @IBOutlet weak var nameLabe: UILabel!
    
    var tempName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.nameLabe.text = tempName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
