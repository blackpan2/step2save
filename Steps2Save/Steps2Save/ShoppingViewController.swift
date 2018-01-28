//
//  ShoppingViewController.swift
//  Steps2Save
//
//  Created by Henry Saniuk on 1/28/18.
//  Copyright © 2018 Sneha Vaswani. All rights reserved.
//

import UIKit

class ShoppingViewController: UIViewController {
    
    @IBOutlet weak var stepCountLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    var steps = 0
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
    
    @objc func increaseStep() {
        steps += 1
        stepsToMax += 1
        progressView.setProgress(Float(stepsToMax) / 100.0, animated: true)
        if (steps == 100) {
            stepsToMax = 0
        }
        self.stepCountLabel.text = "\(steps)"
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
