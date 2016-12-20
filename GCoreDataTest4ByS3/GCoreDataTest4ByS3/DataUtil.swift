//
//  DataUtil.swift
//  GCoreDataTest4ByS3
//
//  Created by 花生 on 20/12/2016.
//  Copyright © 2016年 ihuasheng. All rights reserved.
//

import Foundation
import CoreData
import UIKit

public class DataUtil {
    
    static let dbName = "Students"
    static let sNoColumn = "sNo"
    static let sNameColumn = "sName"
    static let sAgeColumn = "sAge"
    
    static func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    static func getAllStudents() -> [NSManagedObject] {
        let context = getContext()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: dbName)
        var searchResults: [NSManagedObject] = []
        do {
            searchResults = try context.fetch(request) as! [NSManagedObject]
        } catch {
            print("Error in search")
        }
        return searchResults
    }
    
    // Save Student to DataBase
    static func saveData(_ sNo: String, sName: String, sAge: Int16) -> Bool {
        let context = getContext()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: dbName)
        // Locate the student
        let pred = NSPredicate(format: "%K == %@", sNoColumn, sNo)
        request.predicate = pred
        var searchResults: [NSManagedObject] = []
        do {
            searchResults = try context.fetch(request) as! [NSManagedObject]
        } catch {
            print("Error in search")
        }
        if searchResults.count == 1 {
            // Found student and start to modify
            let resultStu = searchResults[0]
            resultStu.setValue(sName, forKey: sNameColumn)
            resultStu.setValue(sAge, forKey: sAgeColumn)
        } else if searchResults.count == 0 {
            // No student match so start to create one
            let newStuEntity = NSEntityDescription.entity(forEntityName: dbName, in: context)
            let newStu = NSManagedObject(entity: newStuEntity!, insertInto: context)
            newStu.setValue(sNo, forKey: sNoColumn)
            newStu.setValue(sName, forKey: sNameColumn)
            newStu.setValue(sAge, forKey: sAgeColumn)
        } else {
            print("More than one result")
            return false
        }
        // Save
        do {
            try context.save()
            return true
        } catch {
            print("Error in save")
            return false
        }
    }
    
    // Delete Student
    static func delData(_ sNo: String) -> Bool {
        let context = getContext()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: dbName)
        // Locate the student
        let pred = NSPredicate(format: "%K == %@", sNoColumn, sNo)
        request.predicate = pred
        var searchResults: [NSManagedObject] = []
        do {
            searchResults = try context.fetch(request) as! [NSManagedObject]
        } catch {
            print("Error in search")
        }
        if searchResults.count == 1 {
            // Found student and start to delete
            context.delete(searchResults[0])
        } else {
            print("More than one result \(searchResults.count)")
            return false
        }
        // Save
        do {
            try context.save()
            return true
        } catch {
            print("Error in save")
            return false
        }
    }
    
}







