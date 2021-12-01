//
//  PurchaseManager.swift
//  SmartWallet
//
//  Created by Matin Massoudi on 11/22/21.
//

import Foundation

class PurchaseManager{
    
    private var purchaseList: [PurchaseItem] = []
    private var userName: String?
    private var userID: String?
    private let sqlManager: SQLManager = SQLManager()
    
    init(userID: String){
        //Populate purchase list with items from users accounts.
        self.userID = userID
        purchaseList = sqlManager.getAllUserPurchases()
    }
    
    func getCount () -> Int{
        return purchaseList.count
    }
    
    func addItem (newItem: PurchaseItem) -> Void{
        purchaseList.append(newItem)
    }
    
    func getItem(index: Int) -> PurchaseItem{
        return purchaseList[index]
    }
    
    func deleteItem(index: Int) -> Void {
        sqlManager.deleteTransaction(transactionID: purchaseList[index].transactionID!)
        purchaseList.remove(at: index)
    }
    
}
