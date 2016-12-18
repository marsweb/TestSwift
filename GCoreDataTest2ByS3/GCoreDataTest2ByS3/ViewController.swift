//
//  ViewController.swift
//  GCoreDataTest2ByS3
//
//  Created by 花生 on 17/12/2016.
//  Copyright © 2016年 ihuasheng. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var name1Text: UITextField!
    @IBOutlet weak var age1Text: UITextField!
    @IBOutlet weak var name2Text: UITextField!
    @IBOutlet weak var age2Text: UITextField!
    @IBOutlet weak var saveTips: UILabel!
    
    private let entityName = "Students"
    private let nameColumn = "sName"
    private let ageColumn = "sAge"
    private let noColumn = "sNo"

    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let context = getContext()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do {
            let searchResults = try context.fetch(request)
            var tempNo: Int32
            var tempAge: Int16
            //for (i, itemResult) in (searchResults as! [NSManagedObject]).enumerated() {
            for itemResult in searchResults as! [NSManagedObject] {
                tempNo = itemResult.value(forKey: noColumn) as! Int32
                tempAge = itemResult.value(forKey: ageColumn) as! Int16
                if tempNo == 1 {
                    name1Text.text = itemResult.value(forKey: nameColumn) as? String
                    age1Text.text = String(tempAge)
                }
                if tempNo == 2 {
                    name2Text.text = itemResult.value(forKey: nameColumn) as? String
                    age2Text.text = String(tempAge)
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

    @IBAction func saveStu(_ sender: Any) {
        let context = getContext()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        var resultText = ""
        do {
            let searchResults = try context.fetch(request)
            if searchResults.count == 0 {
                //CREATE
                let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)
                let stuObj1 = NSManagedObject(entity: entity!, insertInto: context)
                var tempInt = Int16(age1Text.text!)!
                stuObj1.setValue(name1Text.text, forKey: nameColumn)
                stuObj1.setValue(tempInt, forKey: ageColumn)
                stuObj1.setValue(1, forKey: noColumn)
                let stuObj2 = NSManagedObject(entity: entity!, insertInto: context)
                tempInt = Int16(age2Text.text!)!
                stuObj2.setValue(name2Text.text, forKey: nameColumn)
                stuObj2.setValue(tempInt, forKey: ageColumn)
                stuObj2.setValue(2, forKey: noColumn)
                resultText = "Done"
            } else if searchResults.count == 2 {
                //UPDATE
                var tempNo: Int32
                for itemResult in searchResults as! [NSManagedObject] {
                    tempNo = itemResult.value(forKey: noColumn) as! Int32
                    if tempNo == 1 {
                        itemResult.setValue(name1Text.text, forKey: nameColumn)
                        itemResult.setValue(Int16(age1Text.text!), forKey: ageColumn)
                    }
                    if tempNo == 2 {
                        itemResult.setValue(name2Text.text, forKey: nameColumn)
                        itemResult.setValue(Int16(age2Text.text!), forKey: ageColumn)
                    }
                }
                resultText = "Done"
            } else {
                resultText = "Search Error"
            }
            try context.save()
            saveTips.text = resultText
        } catch {
            saveTips.text = "Save Error"
        }
    }
}

