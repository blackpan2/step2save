//
//  ShoppingViewController.swift
//  Steps2Save
//
//  Created by Henry Saniuk on 1/28/18.
//  Copyright © 2018 Sneha Vaswani. All rights reserved.
//

import UIKit
import PMAlertController

class ShoppingViewController: UIViewController {
    
    @IBOutlet weak var stepCountLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    var steps = 0
    var isPaused = false
    var stepsToMax = 0
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stepCountLabel.text = "0"
        increaseStep()
        progressView.setProgress(Float(steps / 100), animated: true)
        progressView.transform = progressView.transform.scaledBy(x: 1, y: 4)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        runTimer()
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.33, target: self,   selector: (#selector(self.increaseStep)), userInfo: nil, repeats: true)
    }
    
    func showCoupon() {
        
        timer.invalidate()
        isPaused = true
        
        let alertVC = PMAlertController(title: "New Coupon", description: "Get $0.50 off Wegmans brand cheese!", image: UIImage(named: "compass"), style: .alert)
        
        alertVC.addAction(PMAlertAction(title: "Add to Wallet", style: .default, action: { () in
            print("Capture action OK")
            self.timer = Timer.scheduledTimer(timeInterval: 0.33, target: self,   selector: (#selector(self.increaseStep)), userInfo: nil, repeats: true)
            self.isPaused = false
        }))
        
        alertVC.addAction(PMAlertAction(title: "No Thanks", style: .cancel, action: { () -> Void in
            print("Capture action Cancel")
            self.timer = Timer.scheduledTimer(timeInterval: 0.33, target: self,   selector: (#selector(self.increaseStep)), userInfo: nil, repeats: true)
            self.isPaused = false
        }))
        
        self.present(alertVC, animated: true, completion: nil)
    }
    
    @objc func increaseStep() {
        steps += 1
        stepsToMax += 1
        progressView.setProgress(Float(stepsToMax) / 100.0, animated: true)
        if (steps % 100 == 0) {
            showCoupon()
            stepsToMax = 0
        }
        self.stepCountLabel.text = "\(steps)"
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
