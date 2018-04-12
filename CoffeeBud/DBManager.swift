//
//  DBManager.swift
//  CoffeeBud
//
//  Created by Sean McCalgan on 2017/07/28.
//  Copyright © 2017 Sean McCalgan. All rights reserved.
//

import UIKit
import Foundation

struct User {
    let userID: Int
    let userName: String
    let userCity: String
    let userSel1: Int
    let userSel2: Int
}

class DBManager: NSObject {
    
    static let shared: DBManager = DBManager()
    
    let databaseFileName = "database.sqlite"
    var pathToDatabase: String!
    var database: FMDatabase!
    
    let field_UserID = "userID"
    let field_UserName = "userName"
    let field_UserCity = "userCity"
    let field_UserSelection1 = "userSel1"
    let field_UserSelection2 = "userSel2"
    
    override init() {
        super.init()
        
        let documentsDirectory = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString) as String
        pathToDatabase = documentsDirectory.appending("/\(databaseFileName)")
    }
    
    func createDatabase() -> Bool {
        var created = false
        
        if !FileManager.default.fileExists(atPath: pathToDatabase) {
            database = FMDatabase(path: pathToDatabase!)
            
            if database != nil {
                // Open the database.
                if database.open() {
                    
                    if createUserTable() {
                        created = true
                    }
                    
                    database.close()
                }
                else {
                    print("Could not open the database.")
                }
            }
        }
        
        return created
    }
    
    func createUserTable() -> Bool {
        var created = false
        let createUserTableQuery = "CREATE TABLE User (\(field_UserID) integer primary key autoincrement not null, \(field_UserName) text not null, \(field_UserCity) text not null, \(field_UserSelection1) bool not null default 0, \(field_UserSelection2) bool not null default 0)"
        
        if database.open() {
            do {
                try database.executeUpdate(createUserTableQuery, values: nil)
                created = true
            }
            catch {
                print("Could not create user table.")
                print(error.localizedDescription)
            }
            
            database.close()
        }
        
        return created
    }

    func openDatabase() -> Bool {
        if database == nil {
            if FileManager.default.fileExists(atPath: pathToDatabase) {
                database = FMDatabase(path: pathToDatabase)
            }
        }
        
        if database != nil {
            if database.open() {
                return true
            }
        }
        
        return false
    }
    
    func insertUserData(userName: String, userCity: String, userSel1: Int, userSel2: Int) {
        // Open the database.
        if openDatabase() {
            var query = ""
            query += "INSERT INTO User (\(field_UserID), \(field_UserName), \(field_UserCity), \(field_UserSelection1), \(field_UserSelection2)) VALUES (null, '\(userName)', '\(userCity)', '\(userSel1)', '\(userSel2)');"
            
            if !database.executeStatements(query) {
                print("Failed to insert user data into the database.")
                print(database.lastError(), database.lastErrorMessage())
            }
            database.close()
        }
    }
    
    func loadUser() -> User {
        var users = User(userID: 0, userName: "", userCity: "", userSel1: 0, userSel2: 0)
        
        if openDatabase() {
            let query = "SELECT * FROM User"
            do {
                let results = try database.executeQuery(query, values: nil)
                
                while results.next() {
                    let userID = results.long(forColumn: field_UserID)
                    let userName = results.string(forColumn: field_UserName)
                    let userCity = results.string(forColumn: field_UserCity)
                    let userSel1 = results.long(forColumn: field_UserSelection1)
                    let userSel2 = results.long(forColumn: field_UserSelection2)
                    
                    users = User(userID: userID, userName: userName!, userCity: userCity!, userSel1: userSel1, userSel2: userSel2)
                    
                }
                
            }
            catch {
                print(error.localizedDescription)
            }
            
            database.close()
            
        }
        
        return users
    }
    
    func updateUser(withID userID: Int, userName: String, userCity: String, userSel1: Int, userSel2: Int) {
        if openDatabase() {
            let query = "UPDATE User SET \(field_UserName)='\(userName)', \(field_UserCity)='\(userCity)', \(field_UserSelection1)='\(userSel1)', \(field_UserSelection2)='\(userSel2)' WHERE \(field_UserID)=\(userID)"
            do {
                try database.executeUpdate(query, values: [userName, userCity, userSel1, userSel2])
            }
            catch {
                print(error.localizedDescription)
            }
            
            print(query)
            database.close()
        }
    }
    
    
    func deleteUser(withID ID: Int) -> Bool {
        var deleted = false
        
        if openDatabase() {
            let query = "DELETE FROM User WHERE \(field_UserID)=\(ID)"
            
            do {
                try database.executeUpdate(query, values: [ID])
                deleted = true
            }
            catch {
                print(error.localizedDescription)
            }
            
            database.close()
        }
        
        return deleted
    }

    
}
