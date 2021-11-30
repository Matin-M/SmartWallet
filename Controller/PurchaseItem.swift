//
//  PurchaseItem.swift
//  SmartWallet
//
//  Created by Matin Massoudi on 11/22/21.
//

import Foundation

class PurchaseItem {
    
    var purchaseID: Double?
    var title: String?
    var date: String?
    var amount: Double?
    var category: String?
    
    init(purchaseID: Double?, title: String?, date: String?, amount: Double?, category: String?) {
        self.purchaseID = purchaseID
        self.title = title
        self.date = date
        self.amount = amount
        self.category = category
    }
    
}
