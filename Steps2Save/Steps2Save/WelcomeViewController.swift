//
//  FirstViewController.swift
//  Steps2Save
//
//  Created by Sneha Vaswani on 1/27/18.
//  Copyright © 2018 Sneha Vaswani. All rights reserved.
//

import UIKit
import SwiftSpinner

class WelcomeViewController: UIViewController {

    @IBOutlet weak var shopButton: UIButton!
    @IBOutlet weak var scanButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shopButton.backgroundColor = .clear
        shopButton.layer.cornerRadius = 5
        shopButton.layer.borderWidth = 2
        shopButton.layer.borderColor = UIColor.white.cgColor
        
        scanButton.backgroundColor = .clear
        scanButton.layer.cornerRadius = 5
        scanButton.layer.borderWidth = 2
        scanButton.layer.borderColor = UIColor.white.cgColor
    }
    
    @IBAction func shopButtonTapped(_ sender: Any) {
        SwiftSpinner.show("Checking Location...")
        let when = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.performSegue(withIdentifier: "start", sender: self)
            SwiftSpinner.hide()
        }
    }
    
    @IBAction func scanButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "scan", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.navigationController?.isNavigationBarHidden = true
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
