//
//  PersonCellViewController.swift
//  Steps2Save
//
//  Created by Henry Saniuk on 1/27/18.
//  Copyright © 2018 Sneha Vaswani. All rights reserved.
//

import Foundation
import UIKit

class PersonCellViewController: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var stepsLabel: UILabel!
    @IBOutlet weak var stepsBackground: UIView!
    @IBOutlet weak var propic: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        stepsBackground.layer.cornerRadius = 15
        propic.layer.cornerRadius = propic.frame.height / 2
        propic.layer.masksToBounds = false
        propic.clipsToBounds = true
    }
    
}
