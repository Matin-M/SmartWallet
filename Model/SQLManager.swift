//
//  SQLManager.swift
//  SmartWallet
//
//  Created by Matin Massoudi on 11/22/21.
//

import Foundation
import PostgresClientKit
import UIKit

class SQLManager{
    
    var userID: String?
    var email: String?
    var password: String?
    
    init() {
        self.userID = StartView.userID
    }
    
    // MARK: General SQLManager functions
    func makePostgreRequest(query: String) -> Cursor? {
        var configuration = PostgresClientKit.ConnectionConfiguration()
        configuration.host = "localhost"
        configuration.port = 8888
        configuration.database = "abejohnson"
        configuration.user = "abejohnson"
        configuration.ssl = false
        
        do{
            //Make Connection
            let connection: Connection = try PostgresClientKit.Connection(configuration: configuration)
            //Parse SQL query, and return server response
            let statement = try connection.prepareStatement(text: query)
            //Use cursor to iterate over rows returned from server response.
            let cursor = try statement.execute()
            return cursor
        }catch{
            print("An error happened!")
            print(error)
        }
        return nil
    }
    
    func generateRandID(length: Int) -> String{
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    // MARK: Functions for Users
    func registerUser(email: String, password: String) -> Void{
        let id = generateRandID(length: 5)
        if let cursor =  makePostgreRequest(query: "INSERT INTO Users (userID, email, passwd) VALUES ('\(id)', '\(email)', '\(password)');"){
            cursor.close()
        }else{
            print("Error!")
        }
    }
    
    func validateCredentials(email: String, passwd: String) -> Bool {
        let query: String = "SELECT * FROM Users;"
        if let cursor: Cursor = makePostgreRequest(query: query){
            do{
                for row in cursor{
                    let columns = try row.get().columns
                    let userID: String = try columns[0].string().filter{!" \n\t\r".contains($0)}
                    let userEmail: String = try columns[1].string().filter{!" \n\t\r".contains($0)}
                    let userPassword: String = try columns[2].string().filter{!" \n\t\r".contains($0)}
                    if(email == userEmail && passwd == userPassword){
                        self.userID = userID
                        StartView.userID = userID
                        self.email = userEmail
                        self.password = userPassword
                        cursor.close()
                        return true
                    }
                }
                cursor.close()
            }catch{
                print(error)
            }
        }else{
            //show error message.
        }
        return false
    }
    
    // MARK: Functions for ContactInfo
    func addContactInfo(name: String, phoneNumber: Int, address: String) -> Void{
        let contactID = generateRandID(length: 5)
        
        if let cursor = makePostgreRequest(query: "UPDATE ContactInfo SET name = '\(name)', phoneNumber = '\(phoneNumber)', address = '\(address)' WHERE ContactInfo.contactID = (SELECT contactID FROM (SELECT userID, contactID FROM ContactInfo INNER JOIN Has using (contactID)) AS Temp WHERE Temp.userID = '\(userID!)');"){
            print("Updated contact information")
            cursor.close()
        }else{
            print("Error updating contact info!")
        }
        
        if let cursor = makePostgreRequest(query: "INSERT INTO ContactInfo (contactID, name, phoneNumber, address) SELECT '\(contactID)', '\(name)', '\(phoneNumber)', '\(address)' WHERE NOT EXISTS (SELECT 1 FROM Has WHERE userID = '\(userID!)');"){
                print("Added contact information")
                cursor.close()
        }else{
            print("Error inserting contact info!")
        }
        
        if let cursor = makePostgreRequest(query: "INSERT INTO Has (userID, contactID) SELECT '\(userID!)', '\(contactID)' WHERE NOT EXISTS (SELECT 1 FROM Has WHERE userID = '\(userID!)');"){
            print("Added contact information")
            cursor.close()
        }else{
            print("Error inserting contact info!")
        }
        
    }
    
    // MARK: Functions for BankAccount
    func insertAccount(accountName: String, funds: Double) {
        let id = generateRandID(length: 8)
        if let accountCursor = makePostgreRequest(query: "INSERT INTO BankAccount (accountID, accountName, funds) VALUES ('\(id)', '\(accountName)', '\(funds)');"){
                print("Added BankAccount")
                accountCursor.close()
        }else{
            print("Error inserting Transaction!")
        }
        
        if let ownsCursor = makePostgreRequest(query: "INSERT INTO Owns (userID, accountID) VALUES ('\(userID!)', '\(id)');"){
                print("Added Owns relationship")
                ownsCursor.close()
        }else{
            print("Error inserting Owns relationship!")
        }
        
    }
    
    func getAllUserAccounts() -> [AccountItem]{
        let query: String = "SELECT userID, accountID, accountName, funds FROM (SELECT * FROM BankAccount INNER JOIN Owns using(accountID)) AS Temp WHERE userID = '\(userID!)';"
        print("Getting all user BankAccounts with userid " + userID!)
        var itemArray: [AccountItem] = []
        if let cursor: Cursor = makePostgreRequest(query: query){
            do{
                for row in cursor{
                    let columns = try row.get().columns
                    let accountID: String = try columns[1].string()
                    let accountName: String = try columns[2].string()
                    let funds: String = try columns[3].string()
                    let newAccountItem: AccountItem = AccountItem(accountID: accountID, accountName: accountName, funds: Double(funds))
                    itemArray.append(newAccountItem)
                }
                cursor.close()
            }catch{
                print(error)
            }
        }
        return itemArray
    }
    
    func getAccountIdFromName(uID: String, name: String) -> String {
        var accountID: String?
        if let cursor = makePostgreRequest(query: "SELECT * FROM (SELECT userID, accountID, accountName, funds FROM (SELECT * FROM BankAccount INNER JOIN Owns using(accountID)) AS Temp WHERE userID = '\(uID)') AS Temp1 WHERE accountName = '\(name)';"){
            print("Getting id from acc \(name) with uid \(uID)")
            do{
                for row in cursor{
                    let columns = try row.get().columns
                    accountID = try columns[1].string()
                }
                if (accountID == nil) {
                    cursor.close()
                    return "Error"
                } else {
                    cursor.close()
                    return accountID!
                }
            } catch {
                print(error)
            }
        }else{
            print("Error getting accountID!")
        }
        return "Error"
    }
    
    func deleteBankAccount(accountID: String) -> Void{
        if let cursor = makePostgreRequest(query: "DELETE FROM BankAccount WHERE accountID = '\(accountID)';"){
            cursor.close()
        }else{
            print("Error deleting BankAccount!")
        }
    }
    
    func getAccountFunds(accountID: String) -> Double{
        var funds: Double = 0
        if let cursor = makePostgreRequest(query: "SELECT funds FROM BankAccount WHERE accountID = '\(accountID)';") {
            do {
                for row in cursor {
                    let columns = try row.get().columns
                    funds = try columns[0].double()
                }
                cursor.close()
                return funds
            } catch {
                print(error)
            }
            cursor.close()
        } else {
            print("Could not retrieve funds!")
        }
        return funds
    }
    
    func getAccountIDOfTransaction(transactionID: String) -> String {
        var aID: String = ""
        if let cursor = makePostgreRequest(query: "SELECT accountID FROM Contains WHERE transactionID = '\(transactionID)';") {
            do {
                for row in cursor {
                    let columns = try row.get().columns
                    aID = try columns[0].string()
                }
                cursor.close()
                return aID
            } catch {
                print(error)
            }
        } else {
            print("Could not get accountID of transaction \(transactionID)!")
        }
        return aID
    }
    
    // MARK: Functions for Transaction
    func insertTransaction(title: String, date: String, amount: Double, category: String, accountID: String) {
        let id = generateRandID(length: 6)
        if let transactionCursor = makePostgreRequest(query: "INSERT INTO Transaction (transactionID, title, date, amount, category) VALUES ('\(id)', '\(title)', '\(date)', '\(amount)', '\(category)');"){
                print("Added Transaction")
                transactionCursor.close()
        }else{
            print("Error inserting Transaction!")
        }
        
        if let transactionCursor = makePostgreRequest(query: "INSERT INTO Contains (accountID, transactionID) VALUES ('\(accountID)', '\(id)');"){
                print("Added Contains relationship")
                transactionCursor.close()
        }else{
            print("Error inserting Contains relationship!")
        }
        
        // Update balance of account
        var funds = getAccountFunds(accountID: accountID)
        funds = funds + amount
        print("Setting funds to: \(funds)")
        if let updateCursor = makePostgreRequest(query: "UPDATE BankAccount SET funds = '\(funds)' WHERE BankAccount.accountID = '\(accountID)';") {
            print("Account: \(accountID) funds updated")
            updateCursor.close()
        } else {
            print("Error updating funds of account: \(accountID)")
        }
    }
    
    func getTransactionAmount(transactionID: String) -> Double {
        var amount: Double = 0
        print("QUERYING: SELECT amount FROM Transaction WHERE transactionID = '\(transactionID)';")
        if let cursor = makePostgreRequest(query: "SELECT amount FROM Transaction WHERE transactionID = '\(transactionID)';") {
            do {
                for row in cursor {
                    let columns = try row.get().columns
                    amount = try columns[0].double()
                    print(amount)
                }
                cursor.close()
                return amount
            } catch {
                print(error)
            }
            cursor.close()
        } else {
            print("Could not retrieve amount!")
        }
        return amount
    }
    
    func getAllUserPurchases() -> [PurchaseItem] {
        let query: String = "SELECT userID, transactionID, title, date, amount, category FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM BankAccount INNER JOIN Owns using(accountID)) AS Temp WHERE userID = '\(userID!)') AS Temp1 INNER JOIN Contains using(accountID)) AS Temp2 INNER JOIN Transaction using(transactionID);"
        print("Getting all user transactions with userid " + userID!)
        var itemArray: [PurchaseItem] = []
        if let cursor: Cursor = makePostgreRequest(query: query){
            do{
                for row in cursor{
                    let columns = try row.get().columns
                    let transactionID: String = try columns[1].string()
                    let title: String = try columns[2].string()
                    let date: String = try columns[3].string()
                    let amount: Double = try columns[4].optionalDouble() ?? 0
                    let category: String = try columns[5].string()
                    let newPurchaseItem: PurchaseItem = PurchaseItem(transactionID: transactionID, title: title, date: date, amount: amount, category: category)
                    itemArray.append(newPurchaseItem)
                }
                cursor.close()
            }catch{
                print(error)
            }
        }
        return itemArray
    }
    
    func getPurchasesByAccountID(accountID: String) -> [PurchaseItem] {
        let query: String = "SELECT transactionID, title, date, amount, category FROM Transaction INNER JOIN (SELECT userID, accountID, transactionID FROM Contains INNER JOIN (SELECT * FROM (SELECT * FROM (SELECT * FROM BankAccount INNER JOIN Owns using(accountID)) AS Temp WHERE userID = '\(userID!)') AS Temp1 WHERE Temp1.accountID = '\(accountID)') AS Temp2 using(accountID)) AS Temp3 using(transactionID);"
        var itemArray: [PurchaseItem] = []
        if let cursor: Cursor = makePostgreRequest(query: query){
            do{
                for row in cursor{
                    let columns = try row.get().columns
                    let transactionID: String = try columns[0].string()
                    let title: String = try columns[1].string()
                    let date: String = try columns[2].string()
                    let amount: Double = try columns[3].optionalDouble() ?? 0
                    let category: String = try columns[4].string()
                    let newPurchaseItem: PurchaseItem = PurchaseItem(transactionID: transactionID, title: title, date: date, amount: amount, category: category)
                    itemArray.append(newPurchaseItem)
                }
                cursor.close()
            }catch{
                print(error)
            }
        }
        return itemArray
    }
    
    func deleteTransaction(transactionID: String, accountID: String) -> Void{
        // Update account funds before deletion
        var funds = getAccountFunds(accountID: accountID)
        print("Current accountfunds: \(funds)")
        let transactionAmt = getTransactionAmount(transactionID: transactionID)
        print("Deleted transaction amount: \(transactionAmt)")
        funds = funds - transactionAmt
        print("After delete, setting funds to \(funds)")
        if let updateCursor = makePostgreRequest(query: "UPDATE BankAccount SET funds = '\(funds)' WHERE BankAccount.accountID = '\(accountID)';") {
            print("Account: \(accountID) funds updated")
            updateCursor.close()
        } else {
            print("Error updating funds of account: \(accountID)")
        }
        
        if let cursor = makePostgreRequest(query: "DELETE FROM Transaction WHERE transactionID = '\(transactionID)';"){
            cursor.close()
        }else{
            print("Error!")
        }
    }
}
