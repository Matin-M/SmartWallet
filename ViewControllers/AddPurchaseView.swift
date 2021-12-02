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
    var accountManager: AccountManager?
    var sqlManager: SQLManager = SQLManager()
    var id: String?
    var name: String?
    var date: String?
    var amount: Double?
    var category: String?
    var added: Bool?
    var accFrom: String?
    var transactionType: Int? = 0 // 0 for withdraw, 1 for deposit
    var userID: String?
    var accountID: String?
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var categoryField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var accountField: UITextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        accountField.text = accFrom
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AddPurchaseView.viewTapped(gestureRecognizer:)))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(AddPurchaseView.dateChanged(datePicker:)), for: .valueChanged)
        
        dateField.inputView = datePicker
        
        self.userID = StartView.userID
        accountManager = AccountManager(userID: userID!)
    }
    
    @IBAction func transactionType(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
            case 0:
                transactionType = 0
            case 1:
                transactionType = 1
            default:
                break
        }
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        // Convert to yyyy-mm-dd format for SQL
        let oldDate = dateFormatter.string(from: datePicker.date)
        let newDate = oldDate.components(separatedBy: "/")
        let convert = "\(newDate[2])-\(newDate[0])-\(newDate[1])"
        
        dateField.text = convert
        view.endEditing(true)
    }
    
    @IBAction func addAccount(_ sender: Any) {
        if (nameField.text != "" && amountField.text != "" && categoryField.text != "" && dateField.text != "" && accountField.text != "") {
            name = nameField.text!
            amount = Double(amountField.text!)
            if (transactionType == 0) {
                amount = amount! * -1
            }
            category = categoryField.text!
            date = dateField.text!
            accountID = sqlManager.getAccountIdFromName(uID: userID!, name: accountField.text!)
            if (accountID != "Error") {
                added = true
                sqlManager.insertTransaction(title: name!, date: date!, amount: amount!, category: category!, accountID: accountID!)
            } else {
                added = false
            }
        } else {
            added = false
            accountID = "False"
        }
    }
}



