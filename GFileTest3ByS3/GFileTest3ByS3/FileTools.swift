//
//  FileTools.swift
//  GFileTest3ByS3
//
//  Created by 花生 on 2/1/2017.
//  Copyright © 2017年 ihuasheng. All rights reserved.
//

import Foundation

class FileTools {
    static func getDocumentsPath(fileName: String) -> String{
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let docDir = paths[0] as NSString
        return docDir.appendingPathComponent(fileName) as String
    }
    
    static func saveArrayToFile(arr: NSArray, fileName: String) -> Bool {
        let filePath = getDocumentsPath(fileName: fileName)
        return arr.write(toFile: filePath, atomically: true)
    }
    
    static func readArrayFromFile(fileName: String) -> [String] {
        let filePath = getDocumentsPath(fileName: fileName)
        if FileManager.default.fileExists(atPath: filePath) {
            return NSArray(contentsOfFile: filePath) as! [String]
        }
        return []
        
    }
}

