//
//  Names.swift
//  NSCodingTest1ByS3
//
//  Created by 花生 on 14/12/2016.
//  Copyright © 2016年 ihuasheng. All rights reserved.
//

import UIKit

class Names: NSObject, NSCoding, NSCopying {
    var names: [String]?
    let namesKey = "namesKey"
    
    override init() {}
    
    required init(coder decoder: NSCoder) {
        names = decoder.decodeObject(forKey: namesKey) as? [String]
    }
    
    func encode(with aCoder: NSCoder) {
        if let saveNames = names {
            aCoder.encode(saveNames, forKey: namesKey)
        }
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = Names()
        if let namesToCopy = names {
            var newNames = Array<String>()
            for tempName in namesToCopy {
                newNames.append(tempName)
            }
            copy.names = newNames
        }
        return copy
    }
    
}
