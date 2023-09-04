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
    func fetchAllMessagesForChatId(chatId: Int64, completion: (() -> Void)? = nil) {
        print("Getting Messages", chatId)
        let fetchedMessages: [MessageModel] = database.fetchMessages(for: chatId)
        DispatchQueue.main.async {
            self.messages = fetchedMessages
            completion?()
        }
    }
   
    func InsertMessages(newMessage: MessageModel) {
        DispatchQueue.main.async {
            Database.shared.insertChat(message: newMessage)
            self.fetchAllMessagesForChatId(chatId: newMessage.chatId)
        }
    }
    
}
