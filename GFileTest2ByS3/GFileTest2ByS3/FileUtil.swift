//
//  FileUtil.swift
//  GFileTest2ByS3
//
//  Created by 花生 on 25/12/2016.
//  Copyright © 2016年 ihuasheng. All rights reserved.
//

import Foundation

class FileUtil {
    static func getDocumentFilePath(fileName: String) -> String {
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let docDir = paths[0] as NSString
        return docDir.appendingPathComponent(fileName) as String
    }
    
    static func saveArrayToDocument(arr: NSArray, fileName: String) -> Bool {
        let filePath = getDocumentFilePath(fileName: fileName)
        return arr.write(toFile: filePath, atomically: true)
    }
    
    static func getArrayFromDocument(fileName: String) -> [String] {
        let filePath = getDocumentFilePath(fileName: fileName)
        if FileManager.default.fileExists(atPath: filePath) {
            return NSArray(contentsOfFile: filePath) as! [String]
        }
        return []
    }
}
