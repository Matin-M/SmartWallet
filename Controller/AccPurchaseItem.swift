//
//  AccPurchaseItem.swift
//  SmartWallet
//
//  Created by Abe Johnson on 11/28/21.
//

import Foundation

class AccPurchaseItem {
    
    var purchaseID: String?
    var title: String?
    var date: String?
    var amount: Double?
    var category: String?
    
    init(purchaseID: String?, title: String?, date: String?, amount: Double?, category: String?) {
        self.purchaseID = purchaseID
        self.title = title
        self.date = date
        self.amount = amount
        self.category = category
    }
    
}
