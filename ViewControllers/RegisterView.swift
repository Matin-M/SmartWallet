//
//  RegisterView.swift
//  SmartWallet
//
//  Created by Abe Johnson on 11/30/21.
//

import Foundation
import UIKit

class RegisterView: UIViewController {
    
    var sqlManager: SQLManager = SQLManager()
    var id: Double?
    var email: String?
    var password: String?
    var added: Bool?
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func registerButton(_ sender: Any) {
        if (emailField.text != "" && passwordField.text != "") {
            email = emailField.text!
            password = passwordField.text!
            added = true
            sqlManager.registerUser(email: email!, password: password!)
        } else {
            added = false
        }
    }
}
