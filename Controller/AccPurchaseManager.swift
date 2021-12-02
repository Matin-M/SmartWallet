//
//  AccPurchaseManager.swift
//  SmartWallet
//
//  Created by Abe Johnson on 11/28/21.
//

import Foundation

class AccPurchaseManager {
    
    private var accPurchaseList: [PurchaseItem] = []
    private let sqlManager: SQLManager = SQLManager()
    private var userName: String?
    private var userID: String?
    
    init(userID: String, accountID: String)
    {
        self.userID = userID
        accPurchaseList = sqlManager.getPurchasesByAccountID(accountID: accountID)
        print("Getting related purchases to \(accountID): \(accPurchaseList.count)")
    }
    
    func getCount () -> Int{
        return accPurchaseList.count
    }
    
    func addItem (newItem: PurchaseItem) -> Void{
        accPurchaseList.append(newItem)
    }
    
    func getItem(index: Int) -> PurchaseItem{
        return accPurchaseList[index]
    }
    
    func deleteItem(index: Int) -> Void {
        let aID = sqlManager.getAccountIDOfTransaction(transactionID: accPurchaseList[index].transactionID!)
        sqlManager.deleteTransaction(transactionID: accPurchaseList[index].transactionID!, accountID: aID)
        accPurchaseList.remove(at: index)
    }
}
