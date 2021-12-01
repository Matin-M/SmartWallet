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
    var password: String?
    
    let OAuthToken: String = ""
    
    init() {
        
    }
    
    func validateCredentials(userid: String, passwd: String) -> Bool {
        let query: String = "SELECT * FROM USERS;"
        var itemArray: [PurchaseItem] = []
        if let cursor: Cursor = makePostgreRequest(query: query){
            do{
                for row in cursor{
                    let columns = try row.get().columns
                    let userID: String = try columns[0].string()
                    let password: String = try columns[1].string()
                    if(userID == userid && password == passwd){
                        self.userID = userID
                        self.password = password
                        return true
                    }
                }
            }catch{
                print(error)
            }
        }else{
            //show error message.
        }
        return false
    }
    
    func getPurchases(userID: String, accountID: String) -> [PurchaseItem] {
        let query: String = "SELECT transactionID, title, date, amount, category FROM Transaction INNER JOIN (SELECT userID, accountID, transactionID FROM Contains INNER JOIN (SELECT * FROM (SELECT * FROM (SELECT * FROM BankAccount INNER JOIN Owns using(accountID)) AS Temp WHERE userID = '\(userID)') AS Temp1 WHERE Temp1.accountID = '\(accountID)') AS Temp2 using(accountID)) AS Temp3 using(transactionID);"
        var itemArray: [PurchaseItem] = []
        if let cursor: Cursor = makePostgreRequest(query: query){
            do{
                for row in cursor{
                    let columns = try row.get().columns
                    let purchaseID: Double = try columns[0].optionalDouble() ?? 0
                    let title: String = try columns[1].string()
                    let date: String = try columns[2].string()
                    let amount: Double = try columns[3].optionalDouble() ?? 0
                    let category: String = try columns[4].string()
                    let newPurchaseItem: PurchaseItem = PurchaseItem(purchaseID: purchaseID, title: title, date: date, amount: amount, category: category)
                    itemArray.append(newPurchaseItem)
                }
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
            connection.close()
            return cursor
        }catch{
            print("An error happened!")
            print(error)
        }
        return nil
    }
    
}
