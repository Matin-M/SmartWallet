//
//  SQLManager.swift
//  SmartWallet
//
//  Created by Matin Massoudi on 11/22/21.
//

import Foundation

struct RowElement: Codable {
    var f: [FieldItem]
}

struct FieldItem: Codable {
    var v: String
}

struct Schema: Codable{
    var fields: [FieldTypes]
}

struct FieldTypes: Codable {
    var name: String
    var type: String
    var mode: String
}

struct SQLObj: Codable {
    var kind: String
    var schema: Schema
    var totalRows: String
    var rows: [RowElement]
}

class SQLManager{
    
    var username: String?
    var password: String?
    
    let OAuthToken: String = ""
    
    init() {
        
    }
    
    func validateCredentials(username: String, password: String) -> Bool {
        let query: String = "SELECT (userid, passwd) FROM Users;"
        let appendedQuery = "WHERE userID = '\(username)' AND passwd = '\(password)'"
        let result: SQLObj = makeBigQueryRequest(query: query, appendedQuery: appendedQuery)!
        return true
    }
    
    func getPurchases(accountID: String) -> [PurchaseItem] {
        let query: String = "SELECT (title, date, amount, category) FROM Purchases;"
        let appendedQuery: String = ""
        let result: SQLObj = makeBigQueryRequest(query: query, appendedQuery: appendedQuery)!
        var item = PurchaseItem(purchaseID: 10, title: "Hello", date: "Hello", amount: 3, category: "Test")
        return [item]
    }
     
    
    func makeBigQueryRequest(query: String, appendedQuery: String) -> SQLObj?{
        let params = ["query": "SELECT * FROM EXTERNAL_QUERY('projects/daring-hash-147405/locations/us/connections/SmartWallet_DB_Source', '\(query)') " + appendedQuery + ";",
                      "useLegacySql": "false"] as Dictionary<String, String>
        var jsonResponse: Dictionary<String, AnyObject>?
        var objResponse: SQLObj? = nil
        var request = URLRequest(url: URL(string: "https://bigquery.googleapis.com/bigquery/v2/projects/daring-hash-147405/queries")!)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(OAuthToken)", forHTTPHeaderField: "Authorization")
        let sem = DispatchSemaphore(value: 0)
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            print(response!)
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                jsonResponse = json
                let objResponse = try JSONDecoder().decode(SQLObj.self, from: data!)
                
            } catch {
                jsonResponse = nil
            }
            sem.signal()
        })

        task.resume()
        sem.wait()
        return objResponse
    }
    
}
