//
//  ViewController.swift
//  GSettingTest3ByS3
//
//  Created by 花生 on 23/12/2016.
//  Copyright © 2016年 ihuasheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var lastTimeLabel: UILabel!
    
    private let defaults = UserDefaults.standard
    
    // Show Log Info to TextFields
    private func showInfo() {
        self.userLabel.text = self.defaults.string(forKey: "user")
        self.lastTimeLabel.text = self.defaults.string(forKey: "lastLogTime")
    }
    
    // Save Log Info to UserDefaults
    private func saveInfo() {
        let curTime = Date()
        let dateFormatter = DateFormatter()
        //dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        self.defaults.set(dateFormatter.string(from: curTime), forKey: "lastLogTime")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Show Info When APP First Load
        self.showInfo()
        
        // Add Two Observer
        let operationQueue = OperationQueue.main
        NotificationCenter.default.addObserver(forName: Notification.Name.UIApplicationDidEnterBackground, object: nil, queue: operationQueue) { (_) in
            self.saveInfo()
        }
        NotificationCenter.default.addObserver(forName: Notification.Name.UIApplicationWillEnterForeground, object: nil, queue: operationQueue) { (_) in
            self.showInfo()
        }
        
        /***** Date Format Tips:
        // EEEE: 代表一天的全名,比如Monday.使用1-3个E就代表简写,比如Mon.
        // MMMM: 代表一个月的全名,比如July.使用1-3个M就代表简写,比如Jul.
        // dd: 代表一个月里的几号,比如07或者30.
        // yyyy: 代表4个数字表示的年份,比如2016.
        // HH: 代表2个数字表示的小时,比如08或17.
        // mm: 代表2个数字表示的分钟,比如01或59.
        // ss: 代表2个数字表示的秒,比如2016.
        // zzz: 代表3个字母表示的时区,比如GTM(格林尼治标准时间,GMT+8为北京所在的时区,俗称东八区)
        // GGG: BC或者AD, 即公元前或者公元
        *****/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

