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

        // Print the values before inserting
        print("""
            Values to be inserted:
            ID: \(message.id)
            Chat ID: \(message.chat.id)
            Sender ID: \(message.sender.id)
            Content: \(message.content)
            Timestamp: \(message.timestamp)
            Status: \(message.status.rawValue)
            """)

        do {
            try db!.run(messages.insert(id <- message.id,
                                        chatId <- message.chat.id,
                                        senderId <- message.sender.id,
                                        content <- message.content,
                                        timestamp <- message.timestamp,
                                        status <- message.status.rawValue
            ))
        } catch {
            print("Insertion of chat failed: \(error)")
        }
    }
    
    func fetchMessages(for chatId: Int64) -> [MessageModel] {
         let messagesTable = Table("messages")
         
         let chatIdExpr = Expression<Int64>("chatId")
         let senderId = Expression<Int64>("senderId")
         let content = Expression<String>("content")
         let timestamp = Expression<Date>("timestamp")
         let status = Expression<String>("status")

         var fetchedMessages: [MessageModel] = []

         do {
             for row in try db!.prepare(messagesTable.filter(chatIdExpr == chatId)) {
                 let message = MessageModel(
                     chatId: row[chatIdExpr],
                     sender: fetchUser(withId: row[senderId])!,
                     content: row[content],
                     timestamp: row[timestamp],
                     status: MessageStatus(rawValue: row[status]) ?? .sent,
                     chat: fetchChat(withId: row[chatIdExpr])!
                 )
                 fetchedMessages.append(message)
             }
         } catch {
             print("Retrieval of messages failed: \(error)")
         }
         return fetchedMessages
     }
}
