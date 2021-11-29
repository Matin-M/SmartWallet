//
//  AccountView.swift
//  SmartWallet
//
//  Created by Abe Johnson on 11/28/21.
//

import Foundation
import UIKit

class AccountView: UIViewController {
    
    var userManager: UserManager?
    var accPurchaseManager: AccPurchaseManager?
    var accountName: String?
    var balance: Double?
    
    @IBOutlet weak var availableBalance: UILabel!
    @IBOutlet weak var purchaseTable: UITableView!
    @IBOutlet weak var accountNavigation: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        self.purchaseTable.backgroundColor = UIColor.black
        self.purchaseTable.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.purchaseTable.rowHeight = 90.0
        accPurchaseManager = AccPurchaseManager(userName: "TestUser", password: "TestPassword")
        accountNavigation.title = accountName
        availableBalance.text = "$\(String(format: "%.2f", self.balance!))"
    }
}

extension AccountView: UITableViewDelegate, UITableViewDataSource {
    // Creates the cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccPurchaseCell", for: indexPath) as! AccPurchaseCell
        let purchaseItem = accPurchaseManager!.getItem(index: indexPath.row)
        cell.purchaseName.text = purchaseItem.title
        cell.purchaseCategory.text = purchaseItem.category
        cell.purchaseAmount.text = "$\(purchaseItem.amount ?? 0.0)"
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
            self.purchaseTable.beginUpdates()
            self.purchaseTable.deleteRows(at: [indexPath], with: .automatic)
            self.purchaseTable.endUpdates()
        }
    }
}
