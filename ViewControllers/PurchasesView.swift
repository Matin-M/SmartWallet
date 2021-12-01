//
//  PurchasesView.swift
//  SmartWallet
//
//  Created by Matin Massoudi on 11/22/21.
//

import Foundation
import UIKit

class PurchasesView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var purchaseManager: PurchaseManager?
    var userID: String?
    
    @IBOutlet weak var purchaseTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        self.purchaseTable.backgroundColor = UIColor.black
        self.purchaseTable.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.purchaseTable.rowHeight = 90.0
        self.userID = StartView.userID
        purchaseManager = PurchaseManager(userID: userID!)
        
    }
    
    @IBAction func addPurchase(_ sender: Any) {
        performSegue(withIdentifier: "AddPurchase", sender: self)
    }
    
    @IBAction func refresh(_ sender: Any) {
        purchaseManager = PurchaseManager(userID: userID!)
        self.purchaseTable.reloadData()
    }
    
    
    // MARK: Segue handling functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "AddPurchase") {
            if let accountView: AddPurchaseView = segue.destination as? AddPurchaseView {
                
            }
        }
    }
    
    // Unwind and update the table with the new account
    @IBAction func unwindToPurchases(segue: UIStoryboardSegue) {
        if let source = segue.source as? AddPurchaseView {
            DispatchQueue.main.async {
                if (source.added == true){
                    // Added succesfully
                    let add = PurchaseItem(transactionID: source.id, title: source.name, date: source.date, amount: source.amount, category: source.category)
                    self.purchaseManager?.addItem(newItem: add)
                    let indexPath = IndexPath(row: (self.purchaseManager?.getCount())! - 1, section: 0)
                    self.purchaseTable.beginUpdates()
                    self.purchaseTable.insertRows(at: [indexPath], with: .automatic)
                    self.purchaseTable.endUpdates()
                } else if (source.added == false && source.index! == -1) {
                    // Specified account not found
                    let alert = UIAlertController(title: "Input Error", message: "Specified account not found", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                } else if (source.added == false && source.index! == -2) {
                    // All forms not filled out
                    let alert = UIAlertController(title: "Input Error", message: "Please fill out all fields", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
            }
        }
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
