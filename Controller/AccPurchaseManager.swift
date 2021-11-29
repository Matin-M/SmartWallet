//
//  AccPurchaseManager.swift
//  SmartWallet
//
//  Created by Abe Johnson on 11/28/21.
//

import Foundation

class AccPurchaseManager {
    
    private var accPurchaseList: [AccPurchaseItem] = []
    private var userName: String?
    
    init(userName: String, password: String)
    {
        //Populate purchase list with items from users accounts.
        
        //Test Data
        addItem(newItem: AccPurchaseItem(purchaseID: 1, title: "M1 Pro Macbook", date: "1/2/21", amount: 3000.01, category: "Technology"))
        addItem(newItem: AccPurchaseItem(purchaseID: 1, title: "Safeway", date: "1/5/21", amount: 100.22, category: "Groceries"))
    }
    
    func getCount () -> Int{
        return accPurchaseList.count
    }
    
    func addItem (newItem: AccPurchaseItem) -> Void{
        accPurchaseList.append(newItem)
    }
    
    func getItem(index: Int) -> AccPurchaseItem{
        return accPurchaseList[index]
    }
    
    func deleteItem(index: Int) -> Void {
        accPurchaseList.remove(at: index)
    }
}
