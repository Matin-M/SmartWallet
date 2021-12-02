//
//  ContactInfoView.swift
//  SmartWallet
//
//  Created by Abe Johnson on 11/30/21.
//

import Foundation
import UIKit

class ContactInfoView: UIViewController {
    
    let sqlManager: SQLManager = SQLManager()
    var name: String?
    var phone: Int?
    var address: String?
    var added: Bool?
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func updateButton(_ sender: Any) {
        if (nameField.text != "" && phoneField.text != "" && addressField.text != "") {
            name = nameField.text!
            phone = Int(phoneField.text!)
            address = addressField.text!
            added = true
            sqlManager.addContactInfo(name: name!, phoneNumber: phone!, address: address!)
        } else {
            added = false
        }
    }
}
