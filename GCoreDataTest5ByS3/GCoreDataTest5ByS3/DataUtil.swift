//
//  DataUtil.swift
//  GCoreDataTest5ByS3
//
//  Created by 花生 on 21/12/2016.
//  Copyright © 2016年 ihuasheng. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DataUtil {
    static let dbName = "Students"
    static let idColumn = "sNo"
    static let nameColumn = "sName"
    static let ageColumn = "sAge"
    
    static func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    static func getStuValueForCell(stu: NSManagedObject) -> String{
        let stuName = stu.value(forKey: nameColumn) as! String
        let stuAge = String(stu.value(forKey: ageColumn) as! Int16)
        return stuName+" , "+stuAge
    }
    
    static func getAllStudent() -> [NSManagedObject] {
        let context = getContext()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: dbName)
        var searchResults: [NSManagedObject] = []
        do {
            searchResults = try context.fetch(request) as! [NSManagedObject]
        } catch {
            print("search error")
        }
        return searchResults
    }
    
    // Check if student's id exist
    static func studentExist(sNo: String) -> Int {
        let context = getContext()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: dbName)
        let pred = NSPredicate(format: "%K == %@", idColumn, sNo)
        request.predicate = pred
        var searchResults: [NSManagedObject] = []
        do {
            searchResults = try context.fetch(request) as! [NSManagedObject]
        } catch {
            print("search error in check student")
        }
        return searchResults.count
    }
    
    static func addStudent(sNo: String, sName: String, sAge: Int16) -> Bool{
        let studentCount = studentExist(sNo: sNo)
        if studentCount == 0 {
            // Add student
            let context = getContext()
            let entity = NSEntityDescription.entity(forEntityName: dbName, in: context)
            let stuObj = NSManagedObject(entity: entity!, insertInto: context)
            stuObj.setValue(sNo, forKey: idColumn)
            stuObj.setValue(sName, forKey: nameColumn)
            stuObj.setValue(sAge, forKey: ageColumn)
            do {
                try context.save()
            } catch {
                print("save error in add Student")
                return false
            }
            return true
        } else {
            // Student's id exist, return error
            print("student already exist")
            return false
        }
    }
    
    static func modifyStudentInfo(sNo: String, sName: String, sAge: Int16) -> Bool {
        let context = getContext()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: dbName)
        let pred = NSPredicate(format: "%K == %@", idColumn, sNo)
        request.predicate = pred
        var searchResults: [NSManagedObject] = []
        do {
            searchResults = try context.fetch(request) as! [NSManagedObject]
        } catch {
            print("search error in check student")
        }
        if searchResults.count == 0 {
            print("student's id does not exist")
            return false
        } else if searchResults.count == 1 {
            // Start to modify
            let stuObj = searchResults[0]
            stuObj.setValue(sName, forKey: nameColumn)
            stuObj.setValue(sAge, forKey: ageColumn)
            do {
                try context.save()
            } catch {
                print("save error in modify Student")
                return false
            }
            return true
        } else {
            print("there are more than one is in database")
            return false
        }
    }
    
    static func delStudent(sNo: String) -> Bool {
        let context = getContext()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: dbName)
        let pred = NSPredicate(format: "%K == %@", idColumn, sNo)
        request.predicate = pred
        var searchResults: [NSManagedObject] = []
        do {
            searchResults = try context.fetch(request) as! [NSManagedObject]
        } catch {
            print("search error in check student")
        }
        if searchResults.count == 0 {
            print("student's id does not exist")
            return false
        } else if searchResults.count == 1 {
            // Start to delete
            context.delete(searchResults[0])
            do {
                try context.save()
            } catch {
                print("save error in delete Student")
                return false
            }
            return true
        } else {
            print("there are more than one is in database")
            return false
        }
    }
}
