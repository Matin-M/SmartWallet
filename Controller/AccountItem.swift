//
//  AccountItem.swift
//  SmartWallet
//
//  Created by Abe Johnson on 11/28/21.
//

import Foundation

class AccountItem {
    
    var accountID: String?
    var accountName: String?
    var funds: Double?
    
    init(accountID: String?, accountName: String?, funds: Double?) {
        self.accountID = accountID
        self.accountName = accountName
        self.funds = funds
    }
}
