//
//  CommunityViewController.swift
//  Steps2Save
//
//  Created by Henry Saniuk on 1/27/18.
//  Copyright © 2018 Sneha Vaswani. All rights reserved.
//

import Foundation
import UIKit
import Haneke

class CommunityViewController: UITableViewController {
    
    var people = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = 80.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.view.backgroundColor = UIColor(red: 195/255.0, green: 60/255.0, blue: 84/255.0, alpha: 1)
        self.tableView.backgroundColor = UIColor(red: 195/255.0, green: 60/255.0, blue: 84/255.0, alpha: 1)
        people.append(Person(name: "Mike Olivera", steps: "4028", propic: "https://s3.amazonaws.com/steps2save/image-1.png"))
        people.append(Person(name: "Frank Smith", steps: "2801", propic: "https://s3.amazonaws.com/steps2save/image-2.png"))
        people.append(Person(name: "Joseph Mellon", steps: "1830", propic: "https://s3.amazonaws.com/steps2save/image-3.png"))
        people.append(Person(name: "Jason Creesey", steps: "1645", propic: "https://s3.amazonaws.com/steps2save/image-4.png"))
        people.append(Person(name: "Guadalupe Gupps", steps: "1528", propic: "https://s3.amazonaws.com/steps2save/image-5.png"))
        people.append(Person(name: "Jeremy Tate", steps: "1418", propic: "https://s3.amazonaws.com/steps2save/image-6.png"))
        people.append(Person(name: "Ruth Rhodes", steps: "1320", propic: "https://s3.amazonaws.com/steps2save/image-7.png"))
        people.append(Person(name: "Barry Tom", steps: "1254", propic: "https://s3.amazonaws.com/steps2save/image-8.png"))
        people.append(Person(name: "Christie Harder", steps: "1149", propic: "https://s3.amazonaws.com/steps2save/image-9.png"))
        people.append(Person(name: "David Baty", steps: "983", propic: "https://s3.amazonaws.com/steps2save/image-10.png"))
        people.append(Person(name: "Brandon Jackson", steps: "842", propic: "https://s3.amazonaws.com/steps2save/image-11.png"))
        people.append(Person(name: "Cameron Mahone", steps: "765", propic: "https://s3.amazonaws.com/steps2save/image-12.png"))
        people.append(Person(name: "David Cook", steps: "666", propic: "https://s3.amazonaws.com/steps2save/image-13.png"))
        people.append(Person(name: "Evelyn Tolliver", steps: "641", propic: "https://s3.amazonaws.com/steps2save/image-14.png"))
        people.append(Person(name: "Kerry Abhernathy", steps: "469", propic: "https://s3.amazonaws.com/steps2save/image-15.png"))
        people.append(Person(name: "Linda Holbrook", steps: "420", propic: "https://s3.amazonaws.com/steps2save/image-16.png"))
        people.append(Person(name: "Oneida Hawthorne", steps: "340", propic: "https://s3.amazonaws.com/steps2save/image-17.png"))
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.people.count
    }
    
    override func tableView(_ tableView: UITableView?, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "header", for: indexPath) as! UITableViewCell
            cell.backgroundColor = UIColor.clear
            return cell
        } else if indexPath.row == 1 {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "topPeople", for: indexPath) as! TopCellViewController
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
            return cell
        } else {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "person", for: indexPath) as! PersonCellViewController
            let person = self.people[indexPath.row]
            cell.nameLabel.text = person.name
            cell.stepsLabel.text = person.steps
            cell.propic.hnk_setImage(from: URL(string: person.propic)!)
            cell.countLabel.text = String(indexPath.row+2)
            return cell
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
