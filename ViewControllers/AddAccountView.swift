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
    
    var sqlManager: SQLManager = SQLManager()
    
    var id: Double?
    var name: String?
    var balance: Double?
    var added: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addAccount(_ sender: Any) {
        if (accountNameField.text != "" && currentBalanceField.text != "") {
            name = accountNameField.text
            balance = Double(currentBalanceField.text!)
            sqlManager.insertAccount(accountName: name!, funds: balance!)
            added = true
        } else {
            added = false
        }
    }
}
