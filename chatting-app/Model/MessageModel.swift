//
//  ChatModel.swift
//  chatting-app
//
//  Created by Imran Abdullah on 29/08/23.
//

import Foundation
import SQLite

enum MessageStatus: String {
case sent, delivered, read

init?(status: String) {
    switch status {
    case "sent":
        self = .sent
    case "delivered":
        self = .delivered
    case "read":
        self = .read
    default:
        return nil
    }
}
}


struct MessageModel: Identifiable {
    let id: Int64
    let chatId: Int64
    let sender: UserModel
    let content: String
    let timestamp: Date
    let status: MessageStatus
    let chat: ChatModel
    
    init(row: Row, userRow: Row, chatRow: Row) {
        id = row[Expression<Int64>("id")]
        chatId = row[Expression<Int64>("chatId")]
        sender = UserModel(row: userRow)
        content = row[Expression<String>("content")]
        timestamp = row[Expression<Date>("timestamp")]
        status = MessageStatus(status: row[Expression<String>("status")]) ?? .sent
        chat = ChatModel(row: chatRow)
    }
    
    init(chatId: Int64, sender: UserModel, content: String, timestamp: Date, status: MessageStatus, chat: ChatModel) {
           self.id = Int64.random(in: 1..<Int64.max) 
           self.chatId = chatId
           self.sender = sender
           self.content = content
           self.timestamp = timestamp
           self.status = status
           self.chat = chat
       }
}

