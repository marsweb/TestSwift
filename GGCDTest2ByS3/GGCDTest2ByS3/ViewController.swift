//
//  ViewController.swift
//  GGCDTest2ByS3
//
//  Created by 花生 on 31/12/2016.
//  Copyright © 2016年 ihuasheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var infoArea: UITextView!
    
    private func connectServer() -> String {
        Thread.sleep(forTimeInterval: 2)
        return "Connecting server..."
    }
    
    private func checkUser() -> String {
        Thread.sleep(forTimeInterval: 2)
        return "Checking user..."
    }
    
    private func getStr() -> String {
        Thread.sleep(forTimeInterval: 2)
        return "Welcome, Mark. "
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func letsStart(_ sender: Any) {
        var str = ""
        startBtn.isEnabled = false
        spinner.startAnimating()
        let queue = DispatchQueue.global()
        let main = DispatchQueue.main
        queue.async {
            str = self.connectServer()
            main.async {
                self.infoArea.text = str
            }
            str = self.checkUser()
            main.async {
                self.infoArea.text = self.infoArea.text+"\n"+str
            }
            str = self.getStr()
            main.async {
                self.infoArea.text = self.infoArea.text+"\n\n"+str
                self.startBtn.isEnabled = true
                self.spinner.stopAnimating()
            }
        }
    }

}

