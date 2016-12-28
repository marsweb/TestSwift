//
//  DataUtil.swift
//  GTest1ByS3
//
//  Created by 花生 on 28/12/2016.
//  Copyright © 2016年 ihuasheng. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DataUtil {
    static private let dbName = "Students"
    static private let noColumn = "sNo"
    static private let nameColumn = "sName"
    static private let picColumn = "sPic"
    
    static func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    // Transform NSManagedObject to Student
    static func transToStu(obj: NSManagedObject) -> Student {
        let stuNo = obj.value(forKey: noColumn) as! String
        let stuName = obj.value(forKey: nameColumn) as! String
        let stuPic = obj.value(forKey: picColumn) as! NSData
        return Student(sNo: stuNo, sName: stuName, sPic: stuPic)
    }
    
    // Search All Student
    static func getAllStudent() -> [Student] {
        let context = getContext()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: dbName)
        var searchResults: [NSManagedObject] = []
        do {
            searchResults = try context.fetch(request) as! [NSManagedObject]
        } catch {
            print("Search Error")
        }
        var results: [Student] = []
        if searchResults.count > 0 {
            for itemResult in searchResults {
                results.append(transToStu(obj: itemResult))
            }
        }
        return results
    }
    
    // Update Student
    static func updateStudentInfo(student: Student) -> Bool {
        let context = getContext()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: dbName)
        let pred = NSPredicate(format: "%K == %@", noColumn, student.sNo)
        request.predicate = pred
        var searchRequests: [NSManagedObject] = []
        do {
            searchRequests = try context.fetch(request) as! [NSManagedObject]
        } catch {
            print("Search Error")
            return false
        }
        if searchRequests.count == 1 {
            searchRequests[0].setValue(student.sName, forKey: nameColumn)
            searchRequests[0].setValue(student.sPic, forKey: picColumn)
            do {
                try context.save()
                return true
            } catch {
                print("Save Error")
                return false
            }
        } else {
            print("Search Result's Count Error")
            return false
        }
    }
    
    // Create Student
    static func createStudent(student: Student) -> Bool {
        let context = getContext()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: dbName)
        let pred = NSPredicate(format: "%K == %@", noColumn, student.sNo)
        request.predicate = pred
        var searchResults: [NSManagedObject] = []
        do {
            searchResults = try context.fetch(request) as! [NSManagedObject]
        } catch {
            print("Search Error")
            return false
        }
        if searchResults.count == 0 {
            let entity = NSEntityDescription.entity(forEntityName: dbName, in: context)
            let newStudent = NSManagedObject(entity: entity!, insertInto: context)
            newStudent.setValue(student.sNo, forKey: noColumn)
            newStudent.setValue(student.sName, forKey: nameColumn)
            newStudent.setValue(student.sPic, forKey: picColumn)
            do {
                try context.save()
                return true
            } catch {
                print("Save Error")
                return false
            }
        } else {
            print("Search Result's Count Error")
            return false
        }
    }
}




































