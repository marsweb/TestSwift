//
//  ViewController.swift
//  GGCDTest1ByS3
//
//  Created by 花生 on 30/12/2016.
//  Copyright © 2016年 ihuasheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var getDataBtn: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var contextArea: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    private func getSomethingFromServer() -> String {
        Thread.sleep(forTimeInterval: 1)
        return "Boom Clap"
    }
    
    private func dealWithData(data: String) -> String {
        Thread.sleep(forTimeInterval: 2)
        return data.uppercased()
    }
    
    private func calculateFirstResult(data: String) -> String {
        Thread.sleep(forTimeInterval: 3)
        return "Number of chars is \(data.characters.count)"
    }
    
    private func calculateSecondResult(data: String) -> String {
        Thread.sleep(forTimeInterval: 4)
        return data.replacingOccurrences(of: "M", with: "MMM")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func getData(_ sender: Any) {
        let startTime = NSDate()
        self.contextArea.text = ""
        self.getDataBtn.isEnabled = false
        spinner.startAnimating()
        // Async
        DispatchQueue.global().async {
            let something = self.getSomethingFromServer()
            let somethingNew = self.dealWithData(data: something)
            var firstResult: String!
            var secondResult: String!
            // Define dispatchGroup
            let group = DispatchGroup()
            DispatchQueue.global(qos: .userInitiated).async(group: group, execute: {
                firstResult = self.calculateFirstResult(data: somethingNew)
            })
            DispatchQueue.global(qos: .userInitiated).async(group: group, execute: {
                secondResult = self.calculateSecondResult(data: somethingNew)
            })
            // Do this part when all group tesks finished
            group.notify(queue: .main, execute: { 
                let resultsSummary = "First: "+firstResult+"\nSecond: "+secondResult
                DispatchQueue.main.async {
                    self.getDataBtn.isEnabled = true
                    self.contextArea.text = resultsSummary
                    self.spinner.stopAnimating()
                }
                let endTime = NSDate()
                print("Completed in \(endTime.timeIntervalSince(startTime as Date)) seconds")
            })
        }
    }

}

