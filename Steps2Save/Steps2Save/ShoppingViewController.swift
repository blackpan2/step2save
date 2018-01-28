//
//  ShoppingViewController.swift
//  Steps2Save
//
//  Created by Henry Saniuk on 1/28/18.
//  Copyright © 2018 Sneha Vaswani. All rights reserved.
//

import UIKit
import PMAlertController
import AudioToolbox

class ShoppingViewController: UIViewController {
    
    @IBOutlet weak var stepCountLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    var steps = 0
    var isPaused = false
    var stepsToMax = 0
    var timer = Timer()
    var couponCount = 0
    var coupons = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stepCountLabel.text = "0"
        increaseStep()
        progressView.setProgress(Float(steps / 100), animated: true)
        progressView.transform = progressView.transform.scaledBy(x: 1, y: 4)
        coupons.append("Get $0.75 off Walnuts!")
        coupons.append("Get $0.75 off Goat Cheese!")
        coupons.append("Get $1 off Carrots!")
        coupons.append("Get $0.50 off Wegmans Brand Cheese!")
        coupons.append("Get $0.50 off Oranges!")
        coupons.append("Get $0.25 off Milk!")
        coupons.append("Get $2 off 2 lbs of Salmon!")
        coupons.append("Get $1 off Wegmans Sushi!")
        coupons.append("Get $0.10 off Wegmans Brand Mac and Cheese!")
    }
    
    @IBAction func closeTapped(_ sender: Any) {
        _ = navigationController?.popToRootViewController(animated: true)
    }
    override func viewDidAppear(_ animated: Bool) {
        runTimer()
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: (#selector(self.increaseStep)), userInfo: nil, repeats: true)
    }
    
    func showCoupon() {
        
        timer.invalidate()
        isPaused = true
        
        if couponCount == 9 {
            couponCount = 0
        }
        
        let alertVC = PMAlertController(title: "New Coupon", description: coupons[couponCount], image: UIImage(named: "coupons"), style: .alert)
        
        alertVC.addAction(PMAlertAction(title: "Add to Wallet", style: .default, action: { () in
            print("Capture action OK")
            self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self,   selector: (#selector(self.increaseStep)), userInfo: nil, repeats: true)
            self.isPaused = false
            self.couponCount += 1
        }))
        
        alertVC.addAction(PMAlertAction(title: "Give to a Friend", style: .default, action: { () in
            print("Capture action OK")
            self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self,   selector: (#selector(self.increaseStep)), userInfo: nil, repeats: true)
            self.isPaused = false
            self.couponCount += 1
        }))
        
        alertVC.addAction(PMAlertAction(title: "No Thanks", style: .cancel, action: { () -> Void in
            print("Capture action Cancel")
            self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self,   selector: (#selector(self.increaseStep)), userInfo: nil, repeats: true)
            self.isPaused = false
            self.couponCount += 1
        }))
        
        self.present(alertVC, animated: true, completion: nil)
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate)) 
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
