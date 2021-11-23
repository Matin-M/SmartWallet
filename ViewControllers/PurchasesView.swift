//
//  PurchasesView.swift
//  SmartWallet
//
//  Created by Matin Massoudi on 11/22/21.
//

import Foundation
import UIKit

class PurchasesView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var userManager: UserManager?
    var purchaseManager: PurchaseManager?
    
    @IBOutlet weak var purchaseTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        self.purchaseTable.backgroundColor = UIColor.black
        self.purchaseTable.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.purchaseTable.rowHeight = 90.0
        purchaseManager = PurchaseManager(userName: "TestUser", password: "TestPassword")
    }
    
    //MARK: - TableView delegate functions.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return purchaseManager?.getCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PurchaseCell", for: indexPath) as! PurchaseCell
        let purchaseItem = purchaseManager!.getItem(index: indexPath.row)
        cell.purchaseName.text = purchaseItem.title
        cell.purchaseCategory.text = purchaseItem.category
        cell.purchaseAmount.text = "$\(purchaseItem.amount ?? 0.0)"
        cell.purchaseDate.text = purchaseItem.date
        return cell
    }
    
    //Delete entries
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool{
        return true
    }
    
    private func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        //Delete item from database.
        purchaseManager!.deleteItem(index: indexPath.row)
        self.purchaseTable.beginUpdates()
        self.purchaseTable.deleteRows(at: [indexPath], with: .automatic)
        self.purchaseTable.endUpdates()
    }
    
}
