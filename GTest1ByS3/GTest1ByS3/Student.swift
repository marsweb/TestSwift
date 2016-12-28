//
//  Student.swift
//  GTest1ByS3
//
//  Created by 花生 on 28/12/2016.
//  Copyright © 2016年 ihuasheng. All rights reserved.
//

import Foundation

class Student: NSObject {
    var sNo: String = ""
    var sName: String = ""
    var sPic: NSData?
    
    override init() {}
    
    required init(sNo: String, sName: String, sPic: NSData) {
        self.sNo = sNo
        self.sName = sName
        self.sPic = sPic
    }
}
