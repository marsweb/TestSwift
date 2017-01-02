//
//  ViewController.swift
//  GFileTest3ByS3
//
//  Created by 花生 on 2/1/2017.
//  Copyright © 2017年 ihuasheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var myTableView: UITableView!
    
    private let fileName: String = "names.plist"
    private let cellID: String = "NameCell"
    private let addSeg: String = "AddSeg"
    private var namesData: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        namesData = FileTools.readArrayFromFile(fileName: fileName)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addName))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        namesData = FileTools.readArrayFromFile(fileName: fileName)
        myTableView.reloadData()
    }
    
    func addName() {
        performSegue(withIdentifier: addSeg, sender: namesData)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return namesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel?.text = namesData[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == addSeg {
            let addVC = segue.destination as! AddNameViewController
            addVC.nameList = sender as! [String]
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

