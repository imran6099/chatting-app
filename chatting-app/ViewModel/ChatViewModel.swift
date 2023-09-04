//
//  ChatViewModel.swift
//  chatting-app
//
//  Created by Imran Abdullah on 03/09/23.
//

import Foundation

class ChatViewModel: ObservableObject {
    private var database: Database = Database.shared
    
    @Published var chats: [ChatModel] = []
    func fetchAllChats() {
            if let fetchedChats = database.fetchAllChats() {
                self.chats = fetchedChats
            }
    }
    
    func getUnchattedContacts() -> [UserModel] {
          // Fetch all users from the database
          let allUsers = database.fetchAllUsers() ?? []
          
          // Fetch all chats from the database
          let allChats = database.fetchAllChats() ?? []
        
         let chattedNumbers = allChats.map { $0.name }
        
          // Filter out users that are not in chats
        let unchattedUsers = allUsers.filter { !chattedNumbers.contains($0.number) }
          
        return unchattedUsers
      }
    
    func deleteChat(chat: ChatModel) {
           database.deleteChat(chat: chat)
           // Fetch chats again or remove the chat from the local array
           fetchAllChats()
       }
    
    @Published var fetchedChat: ChatModel?
    func fetchChatWithNumber(number: String) {
        if let fetchedChat = database.fetchChatByNumber(number: number) {
                self.fetchedChat = fetchedChat
            }
    }
    
}
