//
//  ViewController.swift
//  GTableViewTestByS3
//
//  Created by 花生 on 5/12/2016.
//  Copyright © 2016年 ihuasheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var myTableView: UITableView!
    
    private let names = ["Mark", "Ted", "Jack", "Will", "Grace", "Lucy", "Jason", "Aaron", "Matt", "Justin", "Mike", "Bill"]
    private let cellID : String = "NAMECELL"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Regist Cell
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: TableViewDateSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel?.text = names[indexPath.row]
        return cell
    }
}

