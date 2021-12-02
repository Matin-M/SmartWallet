//
//  AccountView.swift
//  SmartWallet
//
//  Created by Abe Johnson on 11/28/21.
//

import Foundation
import UIKit

class AccountView: UIViewController {
    
    var accPurchaseManager: AccPurchaseManager?
    var sqlManager: SQLManager = SQLManager()
    var accountsView: AccountsView = AccountsView()
    var accountName: String?
    var balance: Double?
    var userID: String?
    
    @IBOutlet weak var availableBalance: UILabel!
    @IBOutlet weak var purchaseTable: UITableView!
    @IBOutlet weak var accountNavigation: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        self.purchaseTable.backgroundColor = UIColor.black
        self.purchaseTable.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.purchaseTable.rowHeight = 90.0
        accountNavigation.title = accountName
        availableBalance.text = "$\(String(format: "%.2f", self.balance!))"
        
        self.userID = StartView.userID
        let accountID = sqlManager.getAccountIdFromName(uID: userID!, name: accountName!)
        accPurchaseManager = AccPurchaseManager(userID: userID!, accountID: accountID)
    }
    
    @IBAction func addPurchase(_ sender: Any) {
        performSegue(withIdentifier: "AddPurchaseFromAcc", sender: self)
    }
    
    // MARK: Segue handling functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "AddPurchaseFromAcc") {
            if let purchaseView: AddPurchaseView = segue.destination as? AddPurchaseView {
                purchaseView.accFrom = accountName
            }
        }
    }
    
    // Unwind and update the table with the new account
    @IBAction func unwindToViewController(segue: UIStoryboardSegue) {
        if let source = segue.source as? AddPurchaseView {
            DispatchQueue.main.async {
                if (source.added == true) {
                    self.accPurchaseManager = AccPurchaseManager(userID: self.userID!, accountID: source.accountID!)
                    let indexPath = IndexPath(row: (self.accPurchaseManager?.getCount())! - 1, section: 0)
                    self.purchaseTable.beginUpdates()
                    self.purchaseTable.insertRows(at: [indexPath], with: .automatic)
                    self.purchaseTable.endUpdates()
                } else if (source.added == false && source.accountID == "Error"){
                    let alert = UIAlertController(title: "Input Error", message: "Specified account not found", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                } else if (source.added == false && source.accountID == "False") {
                    // All forms not filled out
                    let alert = UIAlertController(title: "Input Error", message: "Please fill out all fields", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
}

extension AccountView: UITableViewDelegate, UITableViewDataSource {
    // Creates the cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccPurchaseCell", for: indexPath) as! AccPurchaseCell
        let purchaseItem = accPurchaseManager!.getItem(index: indexPath.row)
        cell.purchaseName.text = purchaseItem.title
        cell.purchaseCategory.text = purchaseItem.category
        if (purchaseItem.amount! > 0) {
            cell.purchaseAmount.text = "$\(String(format: "%.2f", purchaseItem.amount!))"
        } else {
            let temp = -1 * purchaseItem.amount!
            cell.purchaseAmount.text = "- $\(String(format: "%.2f", temp))"
        }
        cell.purchaseDate.text = purchaseItem.date
        return cell
    }
    
    // Setting the number of sections in the table
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Setting the amount of rows in each section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accPurchaseManager?.getCount() ?? 0
    }
    
    // Delete a cell in the table
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // delete data from sneaker table,
        DispatchQueue.main.async {
            self.accPurchaseManager!.deleteItem(index: indexPath.row)
            self.purchaseTable.reloadData()
            let aID = self.sqlManager.getAccountIdFromName(uID: self.userID!, name: self.accountName!)
            self.availableBalance.text = "$\(String(format: "%.2f", self.sqlManager.getAccountFunds(accountID: aID)))"
        }
    }
}
