//
//  ChatModel.swift
//  chatting-app
//
//  Created by Imran Abdullah on 29/08/23.
//

import Foundation

struct ChatMessage: Identifiable {
    let id: UUID
    var sender: String
    var content: String
    var timestamp: Date
    var status: MessageStatus
}

enum MessageStatus {
case sent, delivered, read
}

struct ChatMessageModel: Identifiable {
    let id: Int64
    let chatId: Int64
    var senderId: Int64
    var content: String
    var timestamp: Date
    var status: MessageStatus
}

