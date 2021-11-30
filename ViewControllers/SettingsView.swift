//
//  SettingsView.swift
//  SmartWallet
//
//  Created by Matin Massoudi on 11/22/21.
//

import Foundation
import UIKit

class SettingsView: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
    }
    
    @IBAction func unwindToLogin(segue: UIStoryboardSegue) {
        if let source = segue.source as? ContactInfoView {
            DispatchQueue.main.async {
                if (source.added == false) {
                    let alert = UIAlertController(title: "Input Error", message: "Please fill out all fields", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
}
