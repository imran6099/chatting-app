//
//  SQLiteChatExtension.swift
//  chatting-app
//
//  Created by Imran Abdullah on 03/09/23.
//

import Foundation
import SQLite

extension Database {
    
    func insertChat(chat: ChatModel) {
            let id = Expression<Int64>("id")
            let name = Expression<String>("name")
            let number = Expression<String>("number")
            let isGroupChat = Expression<Bool>("isGroupChat")
            let lastMessageId = Expression<String>("lastMessageId")
            
            do {
                try db!.run(chats.insert(id <- chat.id,
                                         name <- chat.name,
                                         number <- chat.number,
                                         isGroupChat <- chat.isGroupChat,
                                         lastMessageId <- chat.lastMessageId))
            } catch {
                print("Insertion of chat failed: \(error)")
            }
        }
    
    func fetchAllChats() -> [ChatModel]? {
           let id = Expression<Int64>("id")
           let name = Expression<String>("name")
           let number = Expression<String>("number")
           let isGroupChat = Expression<Bool>("isGroupChat")
           let lastMessageId = Expression<String>("lastMessageId")
        
           
           var chatsArray: [ChatModel] = []
           
           do {
               let fetchedChats = try db!.prepare(chats)
               for chatRow in fetchedChats {
                   let fetchedChat = ChatModel(
                       id: chatRow[id],
                       name: chatRow[name],
                       number: chatRow[number],
                       isGroupChat: chatRow[isGroupChat],
                       lastMessageId: chatRow[lastMessageId]
                   )
                   chatsArray.append(fetchedChat)
               }
               return chatsArray
           } catch {
               print("Fetching failed: \(error)")
               return nil
           }
       }
    
     func deleteChat(chat: ChatModel) {
            let chatToDelete = chats.filter(Expression<Int64>("id") == chat.id)
            do {
                try db!.run(chatToDelete.delete())
            } catch {
                print("Delete failed: \(error)")
            }
        }
    
    
    func fetchChatByNumber(number: String) -> ChatModel? {
        let id = Expression<Int64>("id")
        let name = Expression<String>("name")
        let numberExpression = Expression<String>("number")
        let isGroupChat = Expression<Bool>("isGroupChat")
        let lastMessageId = Expression<String>("lastMessageId")

        do {
            let query = chats.filter(numberExpression == number)
            if let chatRow = try db?.pluck(query) {
                return ChatModel(
                    id: chatRow[id],
                    name: chatRow[name],
                    number: chatRow[numberExpression],
                    isGroupChat: chatRow[isGroupChat],
                    lastMessageId: chatRow[lastMessageId]
                )
            } else {
                return nil
            }
        } catch {
            print("Fetching chat by number failed: \(error)")
            return nil
        }
    }
    
    func fetchChat(withId chatId: Int64) -> ChatModel? {
        let chatsTable = Table("chats")
        
        let id = Expression<Int64>("id")
        let name = Expression<String>("name")
        let number = Expression<String>("number")
        let isGroupChat = Expression<Bool>("isGroupChat")
        let lastMessageId = Expression<Int64?>("lastMessageId")
        
        do {
            if let row = try db?.pluck(chatsTable.filter(id == chatId)) {
                return ChatModel(
                    id: row[id],
                    name: row[name],
                    number: row[number],
                    isGroupChat: row[isGroupChat],
                    lastMessageId: String(row[lastMessageId] ?? -1) 
                )
            }
        } catch {
            print("Retrieval of chat failed: \(error)")
        }
        
        return nil
    }
}
    
