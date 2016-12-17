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
            var tempAge: Int16
            for (i, itemResult) in (searchResults as! [NSManagedObject]).enumerated() {
                tempAge = itemResult.value(forKey: ageColumn) as! Int16
                if i == 0 {
                    name1Text.text = itemResult.value(forKey: nameColumn) as? String
                    age1Text.text = String(tempAge)
                }
                if i == 1 {
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
        // TODO Update NOT Create!!!!!!!!!!!
        //let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)
        //let stuObj1 = NSManagedObject(entity: entity!, insertInto: context)
        //var tempInt = Int16(age1Text.text!)!
        //print(tempInt)
        //stuObj1.setValue(name1Text.text, forKey: nameColumn)
        //stuObj1.setValue(tempInt, forKey: ageColumn)
        //let stuObj2 = NSManagedObject(entity: entity!, insertInto: context)
        //tempInt = Int16(age2Text.text!)!
        //stuObj2.setValue(name2Text.text, forKey: nameColumn)
        //stuObj2.setValue(tempInt, forKey: ageColumn)
        do {
            try context.save()
            saveTips.text = "Done"
        } catch {
            saveTips.text = "Save Error"
        }
    }

}

