//
//  ViewController.swift
//  GCoreDataTest3ByS3
//
//  Created by 花生 on 19/12/2016.
//  Copyright © 2016年 ihuasheng. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var no1Label: UILabel!
    @IBOutlet weak var no2Label: UILabel!
    @IBOutlet weak var name1Text: UITextField!
    @IBOutlet weak var name2Text: UITextField!
    @IBOutlet weak var score1Text: UITextField!
    @IBOutlet weak var score2Text: UITextField!
    @IBOutlet weak var saveTips: UILabel!
    
    private let dbName = "Students"
    private let noColumn = "sNo"
    private let nameColumn = "sName"
    private let scoreColumn = "sScore"
    
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // get context
        let context = getContext()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: dbName)
        do {
            let searchResults = try context.fetch(request)
            var tempNo: String
            for itemResult in searchResults as! [NSManagedObject] {
                tempNo = itemResult.value(forKey: noColumn) as! String
                if tempNo == "1" {
                    no1Label.text = "1"
                    name1Text.text = itemResult.value(forKey: nameColumn) as? String
                    score1Text.text = String(itemResult.value(forKey: scoreColumn) as! Int16)
                }
                if tempNo == "2" {
                    no2Label.text = "2"
                    name2Text.text = itemResult.value(forKey: nameColumn) as? String
                    score2Text.text = String(itemResult.value(forKey: scoreColumn) as! Int16)
                }
            }
        } catch {
            saveTips.text = "Search Error"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveScore(_ sender: Any) {
        let context = getContext()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: dbName)
        var resultText = ""
        do {
            let searchResults = try context.fetch(request)
            if searchResults.count == 0 {
                // CREATE
                let entity = NSEntityDescription.entity(forEntityName: dbName, in: context)
                let stuObj1 = NSManagedObject(entity: entity!, insertInto: context)
                stuObj1.setValue("1", forKey: noColumn)
                stuObj1.setValue(name1Text.text, forKey: nameColumn)
                stuObj1.setValue(Int16(score1Text.text!), forKey: scoreColumn)
                let stuObj2 = NSManagedObject(entity: entity!, insertInto: context)
                stuObj2.setValue("2", forKey: noColumn)
                stuObj2.setValue(name2Text.text, forKey: nameColumn)
                stuObj2.setValue(Int16(score2Text.text!), forKey: scoreColumn)
                resultText = "Done"
            } else if searchResults.count == 2 {
                // UPDATE
                var tempNo: String
                for itemResult in searchResults as! [NSManagedObject] {
                    tempNo = itemResult.value(forKey: noColumn) as! String
                    if tempNo == "1" {
                        itemResult.setValue(name1Text.text, forKey: nameColumn)
                        itemResult.setValue(Int16(score1Text.text!), forKey: scoreColumn)
                    }
                    if tempNo == "2" {
                        itemResult.setValue(name2Text.text, forKey: nameColumn)
                        itemResult.setValue(Int16(score2Text.text!), forKey: scoreColumn)
                    }
                }
                resultText = "Done"
            } else {
                resultText = "Serach Error"
            }
            try context.save()
            saveTips.text = resultText
        } catch {
            saveTips.text = "Search Error"
        }
    }
}

