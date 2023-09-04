//
//  ContactView.swift
//  chatting-app
//
//  Created by Imran Abdullah on 03/09/23.
//

import SwiftUI

struct ContactView: View {
    @ObservedObject var viewModel: UserChatViewModel
    
    @AppStorage("userNumber") var currentUserNumber: String = ""
    
    @State private var searchText: String = ""
    @State private var selectedUser: UserModel?
    @State private var isChatActive: Bool = false

    func filteredUsers() -> [UserModel] {
        if searchText.isEmpty {
            return viewModel.users.filter { $0.number != currentUserNumber }
        } else {
            return viewModel.users.filter {
                $0.number != currentUserNumber &&
                $0.name.lowercased().contains(searchText.lowercased())
            }
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                TextField("Search by name...", text: $searchText)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 7)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                List {
                    ForEach(filteredUsers(), id: \.id) { user in
                        Button(action: {
                            self.selectedUser = user
                            self.isChatActive = true
                        }) {
                            VStack(alignment: .leading) {
                                Text(user.name)
                                    .font(.headline)
                                Text(user.number)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
                .navigationBarTitle("Chats")
                .onAppear(perform: viewModel.fetchAllUsers)
                
                if let chosenUser = selectedUser {
                    NavigationLink(
                        destination: ChatWindowView(UserViewModel: viewModel, chat: viewModel.chatForUser(chosenUser)),
                        isActive: $isChatActive,
                        label: {
                            EmptyView()
                        })
                }

            }
        }
    }
}




