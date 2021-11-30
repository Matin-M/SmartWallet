//
//  AddAccountView.swift
//  SmartWallet
//
//  Created by Abe Johnson on 11/29/21.
//

import Foundation
import UIKit

class AddAccountView: UIViewController {
    
    @IBOutlet weak var accountNameField: UITextField!
    @IBOutlet weak var currentBalanceField: UITextField!
    
    var id: Double?
    var name: String?
    var balance: Double?
    var added: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addAccount(_ sender: Any) {
        if (accountNameField.text != "" && currentBalanceField.text != "") {
            id = 8 // Should be unique for DB
            name = accountNameField.text
            balance = Double(currentBalanceField.text!)
            added = true
            // INSERT INTO BankAccount (accountID, accountName, funds) VALUES (id, name, balance)
            // INSERT INTO Owns (userID, accountID) VALUES (userid, id)
        } else {
            added = false
        }
    }
}
