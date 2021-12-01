//
//  RegisterView.swift
//  SmartWallet
//
//  Created by Abe Johnson on 11/30/21.
//

import Foundation
import UIKit

class RegisterView: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var id: Double?
    var email: String?
    var password: String?
    var added: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func registerButton(_ sender: Any) {
        if (emailField.text != "" && passwordField.text != "") {
            id = 8 // Should be unique for DB
            email = emailField.text!
            password = passwordField.text!
            added = true
            // INSERT INTO Users (userID, email, passwd) VALUES (id, email, password);
        } else {
            added = false
        }
    }
}
