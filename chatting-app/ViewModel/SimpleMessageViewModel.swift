//
//  SimpleMessageViewModel.swift
//  chatting-app
//
//  Created by Imran Abdullah on 04/09/23.
//

import Foundation
class SimpleMessageViewModel: ObservableObject {
    @Published var messages: [SimpleMessageModel] = []
    
    func fetchAllMessages() {
        // For simplicity, I'm hardcoding the messages for now
        self.messages = [
            SimpleMessageModel(id: 1, content: "Hello"),
            SimpleMessageModel(id: 2, content: "Hi")
        ]
    }
    
    func insertMessage(content: String) {
        let newMessage = SimpleMessageModel(id: messages.count + 1, content: content)
        messages.append(newMessage)
    }
}
