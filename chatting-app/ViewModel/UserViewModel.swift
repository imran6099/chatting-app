//
//  UserViewModel.swift
//  chatting-app
//
//  Created by Imran Abdullah on 03/09/23.
//

import Foundation

class UserChatViewModel: ObservableObject {
    private var database: Database = Database.shared
    
    func checkAndAddMockUsers() {
        if database.isUsersTableEmpty() {
            let domain = "uatchat2.waafi.com"
            
            let mockUsers: [UserModel] = [
                UserModel(id: 1, name: "Said", number: "900052318228", XMPPJID: "900052318228@\(domain)", lastActive: Date(), isActive: false),
                UserModel(id: 2, name: "Abdullah", number: "900059931779", XMPPJID: "900059931779@\(domain)", lastActive: Date(), isActive: false),
                UserModel(id: 3, name: "Yuusuf", number: "900087689251", XMPPJID: "900087689251@\(domain)", lastActive: Date(), isActive: false),
                UserModel(id: 4, name: "Mohamed", number: "900116482631", XMPPJID: "900116482631@\(domain)", lastActive: Date(), isActive: false)
            ]
            
            for user in mockUsers {
                database.insertUser(user: user)
            }
        }
    }

    @Published var users: [UserModel] = []
    func fetchAllUsers() {
            if let fetchedUsers = database.fetchAllUsers() {
                self.users = fetchedUsers
            }
    }
    
    @Published var fetchedUser: UserModel?
    func fetchUserWithNumber(number: String) {
           if let user = database.fetchUserWithNumber(number: number) {
               self.fetchedUser = user
           } else {
               // Handle if no user is found or some other logic
               print("No user found for the provided number \(number)")
           }
       }
    
    func chatForUser(_ user: UserModel) -> ChatModel {
           print("Attempting to fetch chat for number From Chat For User: \(user.number)")
           if let existingChat = database.fetchChatByNumber(number: user.number) {
               return existingChat
           }

           // If not, create a new chat
           let newChat = ChatModel(
               id: Int64.random(in: 0..<10000), // Consider handling unique IDs properly
               name: user.name,
               number: user.number,
               isGroupChat: false,
               lastMessageId: ""
           )

           database.insertChat(chat: newChat)
           return newChat
       }
    
    

}
