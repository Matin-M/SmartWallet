//
//  PurchaseManager.swift
//  SmartWallet
//
//  Created by Matin Massoudi on 11/22/21.
//

import Foundation

class PurchaseManager{
    
    private var purchaseList: [purchaseItem] = []
    private var userName: String?
    
    
    init(userName: String, password: String)
    {
        //Populate purchase list with items from users accounts.
        
        //Test Data
        addItem(newItem: purchaseItem(purchaseID: 1, title: "M1 Pro Macbook", date: "2021-1-2", amount: 3000.01, category: "Technology"))
        addItem(newItem: purchaseItem(purchaseID: 1, title: "Apple iPad", date: "2021-1-3", amount: 1000.22, category: "Technology"))
        addItem(newItem: purchaseItem(purchaseID: 1, title: "Safeway", date: "2021-1-5", amount: 100.22, category: "Groceries"))
    }
    
    func getCount () -> Int{
        return purchaseList.count
    }
    
    func addItem (newItem: purchaseItem) -> Void{
        purchaseList.append(newItem)
    }
    
    func getItem(index: Int) -> purchaseItem{
        return purchaseList[index]
    }
    
    func deleteItem(index: Int) -> Void {
        purchaseList.remove(at: index)
    }
    
}
