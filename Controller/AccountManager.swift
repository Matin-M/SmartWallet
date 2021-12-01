//
//  AccountManager.swift
//  SmartWallet
//
//  Created by Abe Johnson on 11/28/21.
//

import Foundation

class AccountManager {
    
    private var accountList: [AccountItem] = []
    private var userName: String?
    private var userID: String?
    
    init(userID: String) {
        // Test Data
        self.userID = userID
        addItem(newItem: AccountItem(accountID: 1, accountName: "Wells Fargo Checking", funds: 541.78))
        addItem(newItem: AccountItem(accountID: 2, accountName: "Wells Fargo Savings", funds: 1085.24))
        addItem(newItem: AccountItem(accountID: 3, accountName: "Venmo Account", funds: 36.82))
        addItem(newItem: AccountItem(accountID: 4, accountName: "Chase Checking", funds: 296.09))
    }
    
    func getCount () -> Int{
        return accountList.count
    }
    
    func addItem (newItem: AccountItem) -> Void{
        accountList.append(newItem)
    }
    
    func getItem(index: Int) -> AccountItem{
        return accountList[index]
    }
    
    func getItemNamed(name: String) -> Int{
        var index = -1
        if (accountList.count > 0) {
            for i in (0...accountList.count - 1){
                if name == accountList[i].accountName {
                    index = i
                    break
                }
            }
        }
        return index
    }
    
    func deleteItem(index: Int) -> Void {
        accountList.remove(at: index)
    }
    
}
