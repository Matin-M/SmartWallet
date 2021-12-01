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
    
    func registerUser(email: String, password: String) -> Void{
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let id = String((0..<5).map{ _ in letters.randomElement()! })
        if let cursor =  makePostgreRequest(query: "INSERT INTO Users (userID, email, passwd) VALUES ('\(id)', '\(email)', '\(password)');"){
            cursor.close()
        }else{
            print("Test")
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
    
    func getAllUserPurchases() -> [PurchaseItem] {
        let query: String = "SELECT userID, transactionID, title, date, amount, category FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM BankAccount INNER JOIN Owns using(accountID)) AS Temp WHERE userID = '\(userID!)') AS Temp1 INNER JOIN Contains using(accountID)) AS Temp2 INNER JOIN Transaction using(transactionID);"
        print("Getting all user transactions with userid " + userID!)
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
        }else{
            //show error message.
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
        }else{
            //show error message.
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
