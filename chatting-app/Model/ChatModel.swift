//
//  ChatModel.swift
//  chatting-app
//
//  Created by Imran Abdullah on 29/08/23.
//

import Foundation
import SQLite

struct ChatModel: Identifiable {
    let id: Int64
    let name: String
    let number: String
    let isGroupChat: Bool
    let lastMessageId: String
    
    // Initializer that takes a Row
    init(row: Row) {
        self.id = row[Expression<Int64>("id")]
        self.name = row[Expression<String>("name")]
        self.number = row[Expression<String>("number")]
        self.isGroupChat = row[Expression<Bool>("isGroupChat")]
        self.lastMessageId = row[Expression<String>("lastMessageId")]
    }
    
    init(id: Int64, name: String, number: String, isGroupChat: Bool, lastMessageId: String) {
            self.id = id
            self.name = name
            self.number = number
            self.isGroupChat = isGroupChat
            self.lastMessageId = lastMessageId
        }
}

extension ChatModel {
    static var defaultChat: ChatModel {
        return ChatModel(id: 0, name: "", number: "", isGroupChat: false, lastMessageId: "")
    }
}



