//
//  SimpleChatWindow.swift
//  chatting-app
//
//  Created by Imran Abdullah on 04/09/23.
//

import SwiftUI

struct SimpleChatWindowView: View {
    @ObservedObject var messageViewModel: SimpleMessageViewModel = SimpleMessageViewModel()
    
    @State private var typedMessage: String = ""
    
    var body: some View {
        VStack {
            Button("Test Fetch") {
                let fetchedMessages = Database.shared.fetchMessages(for: 9070)
                print(fetchedMessages)
            }

            ScrollView {
                VStack {
                    ForEach(messageViewModel.messages, id: \.id) { message in
                        Text(message.content)
                    }
                }
            }
            HStack {
                TextField("Type a message...", text: $typedMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                Button("Send") {
                    messageViewModel.insertMessage(content: typedMessage)
                    typedMessage = ""
                }
            }
            .padding(.bottom)
        }
        .onAppear {
            messageViewModel.fetchAllMessages()
        }
    }
}
