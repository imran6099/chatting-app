//
//  ChatView.swift
//  chatting-app
//
//  Created by Imran Abdullah on 29/08/23.
//

import SwiftUI

struct ChatView: View {

    var chats: [Chat]

    init() {
        let john = ChatParticipant(id: UUID(), name: "John Doe", isActive: true)
        let jane = ChatParticipant(id: UUID(), name: "Jane Smith", isActive: false)
        let michael = ChatParticipant(id: UUID(), name: "Michael Jordan", isActive: true)
        let linda = ChatParticipant(id: UUID(), name: "Linda McCartney", isActive: false)
        let paul = ChatParticipant(id: UUID(), name: "Paul McCartney", isActive: true)

        chats = [
            Chat(id: UUID(), name: "John Doe", isGroupChat: false, participants: [john]),
            Chat(id: UUID(), name: "Jane Smith", isGroupChat: false, participants: [jane]),
            Chat(id: UUID(), name: "Basketball Legends", isGroupChat: true, participants: [john, michael]),
            Chat(id: UUID(), name: "Music Club", isGroupChat: true, participants: [linda, paul, jane])
        ]
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(chats, id: \.id) { chat in
                    NavigationLink(destination: ChatWindowView(chat: chat)) {
                        ChatRow(chat: chat)
                    }
                }
            }
            .navigationBarTitle("Chats")
            .navigationBarItems(trailing: Button("New Chat", action: {
                // Handle new chat creation
            }))
        }
    }
}


struct ChatRow: View {
    var chat: Chat

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


struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
