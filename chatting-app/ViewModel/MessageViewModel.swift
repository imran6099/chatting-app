//
//  MessageViewModel.swift
//  chatting-app
//
//  Created by Imran Abdullah on 03/09/23.
//

import Foundation

class MessageViewModel: ObservableObject {
    private var database: Database = Database.shared
    
    @Published var messages: [MessageModel] = []
    func fetchAllMessagesForChatId(chatId: Int64) {
        if let fetchedMessages = database.fetchAllMessagesForChatId(chatId: chatId) {
                self.messages = fetchedMessages
            }
    }
    
    @Published var currentUserMessages: [MessageModel] = []
    func fetchAllMessagesForChatIdAndCurrentNumber(chatId: Int64, currentNumber: String) {
        if let fetchedMessages = database.fetchAllMessagesForChatIdAndCurrentNumber(chatId: chatId, currentNumber: currentNumber) {
                self.messages = fetchedMessages
            }
    }
    
    func InsertMessages(newMessage: MessageModel) {
        Database.shared.insertChat(message: newMessage)
    }
    
    
}
