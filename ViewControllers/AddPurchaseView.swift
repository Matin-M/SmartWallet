//
//  AddPurchaseView.swift
//  SmartWallet
//
//  Created by Abe Johnson on 11/29/21.
//

import Foundation
import UIKit

class AddPurchaseView: UIViewController {
    
    private var datePicker: UIDatePicker?
    var userManager: UserManager?
    var accountManager: AccountManager?
    var selectedAccount: AccountItem?
    var id: Double?
    var name: String?
    var date: String?
    var amount: Double?
    var category: String?
    var index: Int?
    var added: Bool?
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var categoryField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var accountField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AddPurchaseView.viewTapped(gestureRecognizer:)))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(AddPurchaseView.dateChanged(datePicker:)), for: .valueChanged)
        
        dateField.inputView = datePicker
        
        accountManager = AccountManager(userName: "TestUser", password: "TestPassword")
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        // Convert to yyyy-mm-dd for SQL
        let convert = dateFormatter.string(from: datePicker.date)
        
        dateField.text = convert
        view.endEditing(true)
    }
    
    @IBAction func addAccount(_ sender: Any) {
        if (nameField.text != "" && amountField.text != "" && categoryField.text != "" && dateField.text != "" && accountField.text != "") {
            id = 8 // Should be unique for DB
            name = nameField.text!
            amount = Double(amountField.text!)
            category = categoryField.text!
            date = dateField.text!
            index = accountManager?.getItemNamed(name: accountField.text!)
            if (index != -1) {
                selectedAccount = accountManager?.getItem(index: index!)
                added = true
                // INSERT INTO Transaction (transactionID, title, date, amount, category) VALUES (id, name, date, amount, category)
                // INSERT INTO Contains (accountID, transactionID) VALUES (selectedAccount?.accountID, id)
            } else {
                added = false
            }
        } else {
            added = false
            index = -2
        }
    }
}



