//
//  SQLiteMessage.swift
//  chatting-app
//
//  Created by Imran Abdullah on 03/09/23.
//

import Foundation
import SQLite

extension Database {
    
    func insertChat(message: MessageModel) {
            let id = Expression<Int64>("id")
            let chatId = Expression<Int64>("chatId")
            let senderId = Expression<Int64>("senderId")
            let content = Expression<String>("content")
            let timestamp = Expression<Date>("timestamp")
            let status = Expression<String>("status")
            
            do {
                try db!.run(messages.insert(id <- message.id,
                                         chatId <- message.chatId,
                                         senderId <- message.sender.id,
                                         content <- message.content,
                                         timestamp <- message.timestamp,
                                        status <- message.status.rawValue
                                        ))
            } catch {
                print("Insertion of chat failed: \(error)")
            }
        }
    
    func fetchAllMessages() -> [MessageModel]? {
        let chatIdExpr = Expression<Int64>("chatId")
        let senderId = Expression<Int64>("senderId")
        
        var messagesArray: [MessageModel] = []

        do {
            let query = messages.join(users, on: senderId == users[Expression<Int64>("id")])
                                .join(chats, on: chatIdExpr == chats[Expression<Int64>("id")])

            for row in try db!.prepare(query) {
                if let userRow = try db!.pluck(users.filter(Expression<Int64>("id") == row[senderId])) {
                    if let chatRow = try db!.pluck(chats.filter(Expression<Int64>("id") == row[chatIdExpr])) {
                        let message = MessageModel(row: row, userRow: userRow, chatRow: chatRow)
                        messagesArray.append(message)
                    }
                }
            }
            return messagesArray
        } catch {
            print("Retrieval of all messages failed: \(error)")
            return nil
        }
    }


    func fetchAllMessagesForChatId(chatId: Int64) -> [MessageModel]? {
      
        let chatId = Expression<Int64>("messages.chatId")
        let senderId = Expression<Int64>("messages.senderId")

     
        var messagesForChat: [MessageModel] = []

        do {
            let query = messages.join(users, on: senderId == users[Expression<Int64>("id")])
                                .join(chats, on: chatId == chats[Expression<Int64>("id")])
                                .filter(chatId == chatId)

            
            for row in try db!.prepare(query) {
                if let userRow = try db!.pluck(users.filter(Expression<Int64>("id") == row[senderId])) {
                    if let chatRow = try db!.pluck(chats.filter(Expression<Int64>("id") == row[chatId])) {
                        let message = MessageModel(row: row, userRow: userRow, chatRow: chatRow)
                        messagesForChat.append(message)
                    }
                }
            }
            print(messagesForChat)
            return messagesForChat
        } catch {
            print("Retrieval of messages for chat ID \(chatId) failed: \(error)")
            return nil
        }
    }

    func fetchAllMessagesForChatIdAndCurrentNumber(chatId: Int64, currentNumber: String) -> [MessageModel]? {
        let chatIdExpr = Expression<Int64>("messages.chatId")
        let senderId = Expression<Int64>("messages.senderId")
        let number = Expression<String>("number")
        
        var messagesForChat: [MessageModel] = []

        do {
            // Join messages with users and filter by chatId and user's number
            let query = messages.join(users, on: senderId == users[Expression<Int64>("id")])
                                .join(chats, on: chatIdExpr == chats[Expression<Int64>("id")])
                                .filter(chatIdExpr == chatId && users[number] == currentNumber)
            
            // Iterate through the query results
            for row in try db!.prepare(query) {
                if let userRow = try db!.pluck(users.filter(Expression<Int64>("id") == row[senderId])) {
                    if let chatRow = try db!.pluck(chats.filter(Expression<Int64>("id") == row[chatIdExpr])) {
                        let message = MessageModel(row: row, userRow: userRow, chatRow: chatRow)
                        messagesForChat.append(message)
                    }
                }
            }
            print(messagesForChat)
            return messagesForChat
        } catch {
            print("Retrieval of messages for chat ID \(chatId) and user number \(currentNumber) failed: \(error)")
            return nil
        }
    }

    
}
