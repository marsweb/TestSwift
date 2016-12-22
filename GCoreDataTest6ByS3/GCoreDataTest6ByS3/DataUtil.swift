//
//  DataUtil.swift
//  GCoreDataTest6ByS3
//
//  Created by 花生 on 22/12/2016.
//  Copyright © 2016年 ihuasheng. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DataUtil {
    static let dbName = "Students"
    static let noColumn = "sNo"
    static let nameColumn = "sName"
    static let ageColumn = "sAge"
    
    static func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    // NSManageObject -> Student
    static func transToStudent(obj: NSManagedObject) -> Student {
        let stuNo = obj.value(forKey: noColumn) as! String
        let stuName = obj.value(forKey: nameColumn) as! String
        let stuAge = obj.value(forKey: ageColumn) as! Int16
        return Student(sNo: stuNo, sName: stuName, sAge: stuAge)
    }
    
    // Search All Student
    static func getAllStudent() -> [Student] {
        let context = getContext()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: dbName)
        var searchResults: [NSManagedObject] = []
        do {
            searchResults = try context.fetch(request) as! [NSManagedObject]
        } catch {
            print("error in search student list")
        }
        var students: [Student] = []
        if searchResults.count > 0 {
            for itemResult in searchResults {
                students.append(transToStudent(obj: itemResult))
            }
        }
        return students
    }
    
    // Check Student Exist
    static func studentExist(sNo: String) -> Bool {
        let context = getContext()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: dbName)
        let pred = NSPredicate(format: "%K == %@", noColumn, sNo)
        request.predicate = pred
        var searchResults: [NSManagedObject] = []
        do {
            searchResults = try context.fetch(request) as! [NSManagedObject]
        } catch {
            print("error in check student's id")
        }
        if searchResults.count > 0 {
            return true
        }
        return false
    }
    
    // Add Student
    static func addStudent(student: Student) -> Bool{
        if !studentExist(sNo: student.sNo) {
            let context = getContext()
            let entity = NSEntityDescription.entity(forEntityName: dbName, in: context)
            let obj = NSManagedObject(entity: entity!, insertInto: context)
            obj.setValue(student.sNo, forKey: noColumn)
            obj.setValue(student.sName, forKey: nameColumn)
            obj.setValue(student.sAge, forKey: ageColumn)
            do {
                try context.save()
            } catch {
                print("error in save new student")
                return false
            }
            return true
        }
        print("student's id is existed, add failed!")
        return false
    }
    
    
    // Modify Student
    static func modifyStudent(student: Student) -> Bool {
        let context = getContext()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: dbName)
        let pred = NSPredicate(format: "%K == %@", noColumn, student.sNo)
        request.predicate = pred
        var searchResults: [NSManagedObject] = []
        do {
            searchResults = try context.fetch(request) as! [NSManagedObject]
        } catch {
            print("error in modify student")
            return false
        }
        if searchResults.count == 1 {
            searchResults[0].setValue(student.sName, forKey: nameColumn)
            searchResults[0].setValue(student.sAge, forKey: ageColumn)
            do {
                try context.save()
            } catch {
                print("error in modify student")
                return false
            }
            return true
        }
        print("there is no match or there are more than one result!")
        return false
    }
    
    // Delete Student
    static func deleteStudent(sNo: String) -> Bool {
        let context = getContext()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: dbName)
        let pred = NSPredicate(format: "%K == %@", noColumn, sNo)
        request.predicate = pred
        var searchResults: [NSManagedObject] = []
        do {
            searchResults = try context.fetch(request) as! [NSManagedObject]
        } catch {
            print("error in delete student")
            return false
        }
        if searchResults.count == 1 {
            context.delete(searchResults[0])
            do {
                try context.save()
            } catch {
                print("error in delete student")
                return false
            }
            return true
        }
        print("there is no match or there are more than one result!")
        return false
    }
    
}

















