//
//  SQLiteUserExtension.swift
//  chatting-app
//
//  Created by Imran Abdullah on 03/09/23.
//

import Foundation
import SQLite

extension Database {
    func isUsersTableEmpty() -> Bool {
        do {
            let count = try db!.scalar(users.count)
            return count == 0
        } catch {
            print("Error counting users in the database: \(error)")
            return false
        }
    }
    
    // Instert User
    func insertUser(user: UserModel) {
        let id = Expression<Int64>("id")
        let name = Expression<String>("name")
        let number = Expression<String>("number")
        let XMPPJID = Expression<String>("XMPPJID")
        let lastActive = Expression<Date>("lastActive")
        let isActive = Expression<Bool>("isActive")
        
        do {
            try db!.run(users.insert(id <- user.id,
                                     name <- user.name,
                                     number <- user.number,
                                     XMPPJID <- user.XMPPJID,
                                     lastActive <- user.lastActive,
                                     isActive <- user.isActive))
        } catch {
            print("Insertion failed: \(error)")
        }
    }
    
    // Fetch Users
    func fetchAllUsers() -> [UserModel]? {
           let id = Expression<Int64>("id")
           let name = Expression<String>("name")
           let number = Expression<String>("number")
           let XMPPJID = Expression<String>("XMPPJID")
           let lastActive = Expression<Date>("lastActive")
           let isActive = Expression<Bool>("isActive")
           
           var usersArray: [UserModel] = []
           
           do {
               let fetchedUsers = try db!.prepare(users)
               for userRow in fetchedUsers {
                   let fetchedUser = UserModel(
                       id: userRow[id],
                       name: userRow[name],
                       number: userRow[number],
                       XMPPJID: userRow[XMPPJID],
                       lastActive: userRow[lastActive],
                       isActive: userRow[isActive]
                   )
                   usersArray.append(fetchedUser)
               }
               return usersArray
           } catch {
               print("Fetching failed: \(error)")
               return nil
           }
       }
    
    func fetchUserWithNumber(number: String) -> UserModel? {
           let id = Expression<Int64>("id")
           let name = Expression<String>("name")
           let numberExpression = Expression<String>("number")
           let XMPPJID = Expression<String>("XMPPJID")
           let lastActive = Expression<Date>("lastActive")
           let isActive = Expression<Bool>("isActive")

           do {
               let query = users.filter(numberExpression == number)
               if let userRow = try db?.pluck(query) {
                   return UserModel(
                       id: userRow[id],
                       name: userRow[name],
                       number: userRow[numberExpression],
                       XMPPJID: userRow[XMPPJID],
                       lastActive: userRow[lastActive],
                       isActive: userRow[isActive]
                   )
               } else {
                   return nil
               }
           } catch {
               print("Fetching user by number failed: \(error)")
               return nil
           }
       }
    
    func fetchUser(withId userId: Int64) -> UserModel? {
            let usersTable = Table("users")
            
            let id = Expression<Int64>("id")
            let name = Expression<String>("name")
            let number = Expression<String>("number")
            let XMPPJID = Expression<String>("XMPPJID")
            let lastActive = Expression<Date>("lastActive")
            let isActive = Expression<Bool>("isActive")
            
            do {
                if let row = try db?.pluck(usersTable.filter(id == userId)) {
                    return UserModel(
                        id: row[id],
                        name: row[name],
                        number: row[number],
                        XMPPJID: row[XMPPJID],
                        lastActive: row[lastActive],
                        isActive: row[isActive]
                    )
                }
            } catch {
                print("Retrieval of user failed: \(error)")
            }
            
            return nil
        }
       
}

