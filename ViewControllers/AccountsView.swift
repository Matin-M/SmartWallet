//
//  AccountsView.swift
//  SmartWallet
//
//  Created by Abe Johnson on 11/28/21.
//

import Foundation
import UIKit

class AccountsView: UIViewController {
    
    var userManager: UserManager?
    var accountManager: AccountManager?
    var selectedAccount: AccountItem?
    
    @IBOutlet weak var accountsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        self.accountsTable.backgroundColor = UIColor.black
        self.accountsTable.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.accountsTable.rowHeight = 90.0
        accountManager = AccountManager(userName: "TestUser", password: "TestPassword")
        
    }
    
    // Go to Add Account View
    @IBAction func addAccount(_ sender: Any) {
        performSegue(withIdentifier: "AddAccount", sender: self)
    }
    
    // MARK: Segue handling functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "Account") {
            if let accountView: AccountView = segue.destination as? AccountView {
                accountView.accountName = selectedAccount?.accountName
                accountView.balance = selectedAccount?.funds
            }
        } else if (segue.identifier == "AddAccount") {
            
        }
    }
    
    // Unwind and update the table with the new account
    @IBAction func unwindToViewController(segue: UIStoryboardSegue) {
        if let source = segue.source as? AddAccountView {
            DispatchQueue.main.async {
                if (source.added == true) {
                    let add = AccountItem(accountID: source.id, accountName: source.name!, funds: source.balance!)
                    self.accountManager?.addItem(newItem: add)
                    let indexPath = IndexPath(row: (self.accountManager?.getCount())! - 1, section: 0)
                    self.accountsTable.beginUpdates()
                    self.accountsTable.insertRows(at: [indexPath], with: .automatic)
                    self.accountsTable.endUpdates()
                } else {
                    let alert = UIAlertController(title: "Input Error", message: "Please fill out all fields", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
            }
        }
    }
}

extension AccountsView: UITableViewDelegate, UITableViewDataSource {
    // Setting the amount of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountManager?.getCount() ?? 0
    }
    
    // Creates the cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountCell", for: indexPath) as! AccountCell
        let accountItem = accountManager!.getItem(index: indexPath.row)
        cell.accountName.text = accountItem.accountName
        cell.amtAvailable.text = "$\(String(format: "%.2f", accountItem.funds!))"
        return cell
    }
    
    // Perform segue when cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedAccount = accountManager?.getItem(index: indexPath.row)
        print("\(String(describing: selectedAccount?.accountName))'s cell tapped")
        performSegue(withIdentifier: "Account", sender: self)
    }
    
    // Delete a cell in the table
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.accountManager!.deleteItem(index: indexPath.row)
            self.accountsTable.beginUpdates()
            self.accountsTable.deleteRows(at: [indexPath], with: .automatic)
            self.accountsTable.endUpdates()
        }
    }
}
