//
//  ViewController.swift
//  GCoreDataTest1ByS3
//
//  Created by 花生 on 16/12/2016.
//  Copyright © 2016年 ihuasheng. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var name1Text: UITextField!
    @IBOutlet weak var name2Text: UITextField!
    @IBOutlet weak var saveTips: UILabel!
    
    private let entityName = "Names"
    private let nameIndex = "nNo"
    private let nameText = "nName"
    
    // get context
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // get context
        let context = getContext()
        // get request
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        // search and read them
        do {
            let searchResults = try context.fetch(request)
            for itemResult in searchResults as! [NSManagedObject] {
                let nameIndex: Int16 = itemResult.value(forKey: self.nameIndex) as! Int16
                if nameIndex == 1 {
                    name1Text.text = itemResult.value(forKey: nameText) as? String
                }
                if nameIndex == 2 {
                    name2Text.text = itemResult.value(forKey: nameText) as? String
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

    @IBAction func saveNames(_ sender: Any) {
        // get context
        let context = getContext()
        // define a entity
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)
        // this part not sure
        let nameObj1 = NSManagedObject(entity: entity!, insertInto: context)
        nameObj1.setValue(name1Text.text, forKey: nameText)
        nameObj1.setValue(1, forKey: nameIndex)
        let nameObj2 = NSManagedObject(entity: entity!, insertInto: context)
        nameObj2.setValue(name2Text.text, forKey: nameText)
        nameObj2.setValue(2, forKey: nameIndex)
        // save context
        do {
            try context.save()
            saveTips.text = "Done"
        } catch {
            saveTips.text = "Save Error"
        }
    }
}

