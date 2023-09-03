//
//  ChatWindowView.swift
//  chatting-app
//
//  Created by Imran Abdullah on 29/08/23.
//

import SwiftUI

struct ChatWindowView: View {
    var chat: Chat
    @State private var typedMessage: String = ""
    
    func profileImage(for name: String) -> Image {
        // Placeholder for now; replace this with your method of obtaining user images
        return Image(systemName: "person.circle")
    }
    
    var messages: [ChatMessage] = [
        ChatMessage(id: UUID(), sender: "John", content: "Hello!", timestamp: Date().addingTimeInterval(-3600), status: .read),
        ChatMessage(id: UUID(), sender: "Me", content: "How are you?", timestamp: Date().addingTimeInterval(-1800), status: .read),
        ChatMessage(id: UUID(), sender: "John", content: "I'm doing well!", timestamp: Date(), status: .delivered)
    ]
    
    var presenceStatus: String {
            guard !chat.isGroupChat, let participant = chat.participants.first else {
                return ""
            }
            
            if participant.isActive {
                return "Online"
            } else {
                // Assuming you have a lastSeen property in ChatParticipant or a similar method to fetch this data
                let formatter = DateFormatter()
                formatter.timeStyle = .short
                return "Last seen at \(formatter.string(from: Date()))" // Use the actual last seen date here
            }
        }
    
    var body: some View {
        VStack {
            if !chat.isGroupChat {
                          HStack {
                              profileImage(for: chat.name)
                                  .resizable()
                                  .scaledToFit()
                                  .frame(width: 50, height: 50)
                                  .clipShape(Circle())
                                  .padding(.trailing, 10)
                              
                              Text(presenceStatus)
                                  .font(.caption)
                                  .foregroundColor(.gray)
                              
                              Spacer()
                          }
                          .padding([.top, .leading, .trailing])
                      }
            
            List(messages) { message in
                HStack {
                    if chat.isGroupChat && message.sender != "Me" {
                        profileImage(for: message.sender)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                            .padding(.trailing, 5)
                    }
                    
                    MessageRow(message: message)
                    
                    if message.sender == "Me" {
                        Spacer()
                    }
                }
            }
                
                HStack {
                    TextField("Type a message...", text: $typedMessage)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    Button("Send") {
                        // Handle sending the message
                    }
                    .padding(.trailing)
                }
                .padding(.bottom)
            }
            .navigationBarTitle(chat.name, displayMode: .inline)
        }
        
    }

