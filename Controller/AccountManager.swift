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
    private let sqlManager: SQLManager = SQLManager()
    
    init(userID: String) {
        // Test Data
        self.userID = userID
        accountList = sqlManager.getAllUserAccounts()
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
        sqlManager.deleteBankAccount(accountID: accountList[index].accountID!)
        accountList.remove(at: index)
    }
    
}
