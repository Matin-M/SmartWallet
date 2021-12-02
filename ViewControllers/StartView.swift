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
    @IBOutlet weak var greetingLabel: UILabel!
    public static var userID: String?
    
    let credentials: SQLManager = SQLManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginButton(_ sender: Any) {
        //Validate login information, then toggle segue.
        if(credentials.validateCredentials(email: usernameField.text ?? "N/A", passwd: passwordField.text ?? "N/A")){
            performSegue(withIdentifier: "login", sender: nil)
        }else{
            greetingLabel.text = "Incorrect username or password, please try again!"
            greetingLabel.textColor = UIColor.red
        }
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
