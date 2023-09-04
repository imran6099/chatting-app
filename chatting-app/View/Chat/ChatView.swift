//
//  ChatView.swift
//  chatting-app
//
//  Created by Imran Abdullah on 29/08/23.
//

import SwiftUI

struct ChatView: View {
    @ObservedObject var viewModel: ChatViewModel
    @ObservedObject var UserViewModel: UserChatViewModel
    
    func deleteChat(at offsets: IndexSet) {
           offsets.forEach { index in
               let chat = viewModel.chats[index]
               viewModel.deleteChat(chat: chat)
           }
       }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.chats, id: \.id) { chat in
                            NavigationLink(destination: ChatWindowView(UserViewModel: UserViewModel, chat: chat)) {
                                ChatRow(chat: chat)
                            }
                           }
                           .onDelete(perform: deleteChat)
                       }
                       .navigationBarTitle("Chats")
                       .onAppear(perform: viewModel.fetchAllChats)
                       .navigationBarItems(trailing: EditButton())
        }
    }
}


struct ChatRow: View {
    var chat: ChatModel

    var body: some View {
        HStack {
            if chat.isGroupChat {
                // Display a group icon or multiple participant icons
                Image(systemName: "person.3.fill")
            } else {
                // Display an individual's icon or image
                Image(systemName: "person.circle")
            }
            
            Text(chat.name)
            Spacer()
            // Add timestamp or latest message preview if needed
        }
    }
}
