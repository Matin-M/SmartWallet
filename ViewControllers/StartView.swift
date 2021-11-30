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
    
    
    
    
}
