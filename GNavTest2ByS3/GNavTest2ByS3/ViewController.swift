//
//  ViewController.swift
//  GNavTest2ByS3
//
//  Created by 花生 on 8/12/2016.
//  Copyright © 2016年 ihuasheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!
    
    private let names = ["Mark", "Ted", "Jack", "Will", "Grace", "Lucy", "Jason", "Aaron", "Matt", "Justin", "Mike", "Bill", "Jack", "Jerry", "Peter", "Tom", "Lily", "John", "Ben", "Ricky", "Oliver", "Wendy", "Nick", "Vivan", "Zack", "Karen", "Gary", "Don"]
    private let cellID: String = "NAMECELL"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Name List"
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel?.text = names[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "NameSeg", sender: names[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NameSeg" {
            let nameVC = segue.destination as! NameViewController
            nameVC.tempName = sender as! String
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.purple
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(headerGo))
        headerView.addGestureRecognizer(tapGR)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func headerGo(sender: UITapGestureRecognizer) {
        self.performSegue(withIdentifier: "HeaderSeg", sender: nil)
    }
    
}

