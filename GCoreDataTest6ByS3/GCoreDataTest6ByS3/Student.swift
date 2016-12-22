//
//  Student.swift
//  GCoreDataTest6ByS3
//
//  Created by 花生 on 22/12/2016.
//  Copyright © 2016年 ihuasheng. All rights reserved.
//

import Foundation

class Student: NSObject {
    var sNo: String = ""
    var sName: String = ""
    var sAge: Int16 = 0
    
    override init() {}
    
    required init(sNo: String, sName: String, sAge: Int16) {
        self.sNo = sNo
        self.sName = sName
        self.sAge = sAge
    }

}
