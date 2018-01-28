//
//  ShoppingListViewController.swift
//  Steps2Save
//
//  Created by Henry Saniuk on 1/28/18.
//  Copyright © 2018 Sneha Vaswani. All rights reserved.
//

import Foundation
import UIKit

class ShoppingListViewController: UIViewController {
    
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstButton.backgroundColor = .clear
        firstButton.layer.cornerRadius = 5
        firstButton.layer.borderWidth = 2
        firstButton.layer.borderColor = UIColor.white.cgColor
        
        secondButton.backgroundColor = .clear
        secondButton.layer.cornerRadius = 5
        secondButton.layer.borderWidth = 2
        secondButton.layer.borderColor = UIColor.white.cgColor
        
        thirdButton.backgroundColor = .clear
        thirdButton.layer.cornerRadius = 5
        thirdButton.layer.borderWidth = 2
        thirdButton.layer.borderColor = UIColor.white.cgColor
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "start2", sender: self)
    }

}
