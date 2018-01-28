//
//  FirstViewController.swift
//  Steps2Save
//
//  Created by Sneha Vaswani on 1/27/18.
//  Copyright © 2018 Sneha Vaswani. All rights reserved.
//

import UIKit
import SwiftSpinner
import BarcodeScanner

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
        let viewController = makeBarcodeScannerController()
        viewController.title = "Barcode Scanner"
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    private func makeBarcodeScannerController() -> BarcodeScannerController {
        let viewController = BarcodeScannerController()
        viewController.codeDelegate = self
        return viewController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.navigationController?.isNavigationBarHidden = true
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension WelcomeViewController: BarcodeScannerCodeDelegate {
    func barcodeScanner(_ controller: BarcodeScannerController, didCaptureCode code: String, type: String) {
        print(code)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            controller.resetWithError()
        }
    }
    
    func scanner(_ controller: BarcodeScannerController, didReceiveError error: Error) {
        print(error)
    }
    
    func scannerDidDismiss(_ controller: BarcodeScannerController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func scanner(_ controller: BarcodeScannerController, didCaptureCode code: String, type: String) {
        print("Barcode Data: \(code)")
        print("Symbology Type: \(type)")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            controller.reset(animated: true)
            _ = self.navigationController?.popToRootViewController(animated: true)
        }
    }
}
