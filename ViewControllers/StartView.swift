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
    
    let credentials: SQLManager = SQLManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginButton(_ sender: Any) {
        //Validate login informatin, then toggle segue.
        if(credentials.validateCredentials(userid: usernameField.text ?? "N/A", passwd: passwordField.text ?? "N/A")){
            performSegue(withIdentifier: "login", sender: nil)
        }else{
            greetingLabel.text = "Incorrect sername or password, please try again!"
            greetingLabel.textColor = UIColor.red
        }
    }
    
    
}
