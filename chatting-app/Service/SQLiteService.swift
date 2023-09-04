//
//  SQLiteService.swift
//  chatting-app
//
//  Created by Imran Abdullah on 03/09/23.
//

import Foundation
import SQLite

class Database {
    static let shared = Database()
    internal var db: Connection?
    
    // Table Definitions
    internal let users = Table("users")
    internal let chats = Table("chats")
    internal let messages = Table("messages")
    internal let chatParticipants = Table("chat_participants")

    private init() {
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
        ).first!
        do {
            db = try Connection("\(path)/db.sqlite3")
            try db!.execute("PRAGMA foreign_keys = ON")
            createTableUsers()
            createTableChats()
            createTableMessages()
            createTableChatParticipants()
        } catch {
            db = nil
            print ("Unable to open database")
        }
    }
    
    // Creating Database tables
    
    func createTableUsers() {
        do {
            try db!.run(users.create(ifNotExists: true) { table in
                table.column(Expression<Int64>("id"), primaryKey: .autoincrement)
                table.column(Expression<String>("name"))
                table.column(Expression<String>("number"))
                table.column(Expression<String>("XMPPJID"))
                table.column(Expression<Date>("lastActive"))
                table.column(Expression<Bool>("isActive"))
            })
        } catch {
            print("Unable to create table")
        }
    }
    
    func createTableChats() {
        do {
            try db!.run(chats.create(ifNotExists: true) { table in
                table.column(Expression<Int64>("id"), primaryKey: .autoincrement)
                table.column(Expression<String>("name"))
                table.column(Expression<String>("number"))
                table.column(Expression<Bool>("isGroupChat"))
                table.column(Expression<Int64?>("lastMessageId"))
            })
        } catch {
            print("Unable to create table")
        }
    }

    func createTableMessages() {
        do {
            try db!.run(messages.create(ifNotExists: true) { table in
                table.column(Expression<Int64>("id"), primaryKey: .autoincrement)
                table.column(Expression<Int64>("chatId"))
                table.column(Expression<Int64>("senderId"))
                table.column(Expression<String>("content"))
                table.column(Expression<Date>("timestamp"))
                table.column(Expression<String>("status"))
            })
        } catch {
            print("Unable to create table")
        }
    }

    
    func createTableChatParticipants() {
        do {
            try db!.run(chatParticipants.create(ifNotExists: true) { table in
                table.column(Expression<Int64>("chatId"))
                table.column(Expression<Int64>("userId"))
            })
        } catch {
            print("Unable to create table")
        }
    }
  
}
