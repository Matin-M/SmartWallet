//
//  StartView.swift
//  SmartWallet
//
//  Created by Matin Massoudi on 11/22/21.
//

import Foundation
import UIKit
//import PerfectPostgreSQL

class StartView: UIViewController {
    
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let p = PGConnection()
//        let status = p.connectdb("host=34.125.38.32 dbname=postgres")
//        defer {
//            print("Status = \(status)")
//            p.close() // close the connection
//        }
    }
    
    @IBAction func loginButton(_ sender: Any) {
        //Validate login informatin, then toggle segue. 
        performSegue(withIdentifier: "login", sender: nil)
    }
    
    @IBAction func registerButton(_ sender: Any) {
        performSegue(withIdentifier: "Register", sender: self)
    }
    
    @IBAction func unwindToLogin(segue: UIStoryboardSegue) {
        if let source = segue.source as? RegisterView {
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
