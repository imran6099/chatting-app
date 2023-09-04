//
//  ChatWindowView.swift
//  chatting-app
//
//  Created by Imran Abdullah on 29/08/23.
//

import SwiftUI

struct ChatWindowView: View {
    @ObservedObject var messageViewModel: MessageViewModel = MessageViewModel()
    @ObservedObject var UserViewModel: UserChatViewModel
    
    @AppStorage("userNumber") var currentUserNumber: String = ""
    @AppStorage("userPassword") var userPassword: String = ""

    let xmppService = XMPPService.shared
    let domain = "uatchat2.waafi.com"
    
    var chat: ChatModel
    @State private var typedMessage: String = ""
    
    func profileImage(for name: String) -> Image {
        return Image(systemName: "person.circle")
    }
    
    func storeAndClearMessage() {
        let currentUser = UserModel(id: UserViewModel.fetchedUser?.id ?? 1, name: "", number: currentUserNumber, XMPPJID: "\(currentUserNumber)@\(domain)", lastActive: Date(), isActive: true)
        
        let newMessage = MessageModel(
                                      chatId: chat.id,
                                      sender: currentUser,
                                      content: typedMessage,
                                      timestamp: Date(),
                                      status: .sent,
                                      chat: chat)
      
        messageViewModel.InsertMessages(newMessage: newMessage)
        // Clear the typed message
        typedMessage = ""
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
                              
//                              Text(presenceStatus)
//                                  .font(.caption)
//                                  .foregroundColor(.gray)
                              
                              Text(chat.number)
                              Spacer()
                          }
                          .padding([.top, .leading, .trailing])
                      }
            
            List {
                ForEach(messageViewModel.messages, id: \.id) { message in
                    HStack {
                        if chat.isGroupChat && message.sender.number != currentUserNumber {
                            profileImage(for: message.sender.name)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                                .padding(.trailing, 5)
                        }
                        
                        MessageRow(message: message)
                        
                        if message.sender.number == currentUserNumber {
                            Spacer()
                        }
                    }
                }
            }
            .onAppear {
                UserViewModel.fetchUserWithNumber(number: currentUserNumber)
                messageViewModel.fetchAllMessagesForChatId(chatId: chat.id)
            }
                
                HStack {
                    TextField("Type a message...", text: $typedMessage)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    Button("Send") {
                        if !xmppService.isXmppConnected {
                            // Connect before sending
                            XMPPService.shared.connect(hostName: domain, port: 5222, username: "\(currentUserNumber)@\(domain)", password: userPassword) { success, error in
                                DispatchQueue.main.async {
                                    if success {
                                        xmppService.sendMessage(to: UserViewModel.fetchedUser?.XMPPJID ?? "\(chat.number)@\(domain)", content: typedMessage)
                                        storeAndClearMessage()  // Function to store the message and clear the typedMessage.
                                    } else {
                                        print("Failed to connect before sending the message.")
                                    }
                                }
                            }
                        } else {
                            xmppService.sendMessage(to: UserViewModel.fetchedUser?.XMPPJID ?? "\(chat.number)@\(domain)", content: typedMessage)
                            storeAndClearMessage()  // Function to store the message and clear the typedMessage.
                        }
                    }


                }
                .padding(.bottom)
            }
            .navigationBarTitle(chat.name, displayMode: .inline)
            .onAppear {
                UserViewModel.fetchUserWithNumber(number: currentUserNumber)
                messageViewModel.fetchAllMessagesForChatId(chatId: chat.id)
            }
        }
        
    }

