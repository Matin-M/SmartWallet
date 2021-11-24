//
//  StartView.swift
//  SmartWallet
//
//  Created by Matin Massoudi on 11/22/21.
//

import Foundation
import UIKit

class StartView: UIViewController {
    
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginButton(_ sender: Any) {
        //Validate login informatin, then toggle segue. 
        performSegue(withIdentifier: "login", sender: nil)
    }
    
    
}
