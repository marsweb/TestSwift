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
    
    private let names = ["Mark", "Ted", "Jack", "Will", "Grace", "Lucy", "Jason", "Aaron", "Matt", "Justin", "Mike", "Bill", "Jack", "Jerry", "Peter", "Tom", "Lily", "John", "Ben", "Ricky", "Oliver", "Wendy", "Nick", "Vivan", "Zack", "Karen", "Gary", "Don"]
    private let cellID : String = "NAMECELL"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Regist Cell
        myTableView.register(ItemCell.self, forCellReuseIdentifier: cellID)
        //let headerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        //headerView.backgroundColor = UIColor.blue
        //myTableView.tableHeaderView = headerView
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
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ItemCell
        cell.name = names[indexPath.row]
        return cell
    }
    
    //MARK: TableViewDelegate
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        headerView.backgroundColor = UIColor.blue
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}

