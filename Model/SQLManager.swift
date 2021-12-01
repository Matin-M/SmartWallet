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
    
    func deleteTransaction(transactionID: String) -> Void{
        if let cursor = makePostgreRequest(query: "DELETE FROM Transaction WHERE transactionID = '\(transactionID)';"){
            cursor.close()
        }else{
            print("Error!")
        }
    }
    
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
    
    func registerUser(email: String, password: String) -> Void{
        let id = generateRandID(length: 5)
        if let cursor =  makePostgreRequest(query: "INSERT INTO Users (userID, email, passwd) VALUES ('\(id)', '\(email)', '\(password)');"){
            cursor.close()
        }else{
            print("Error!")
        }
    }
    
    func generateRandID(length: Int) -> String{
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
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
    
    func makePostgreRequest(query: String) -> Cursor? {
        var configuration = PostgresClientKit.ConnectionConfiguration()
        configuration.host = "localhost"
        configuration.port = 8888
        configuration.database = "SmartWalletDB"
        configuration.user = "matinmassoudi"
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
    
}
