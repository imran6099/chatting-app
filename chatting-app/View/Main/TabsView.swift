//
//  NavigationView.swift
//  chatting-app
//
//  Created by Imran Abdullah on 02/09/23.
//

import SwiftUI

struct TabsView: View {
    @State private var selectedTab = 0
    @State private var isContactsSheetPresented = false
    @ObservedObject var viewModel: UserChatViewModel = UserChatViewModel()
    @ObservedObject var ChatviewModel: ChatViewModel = ChatViewModel()
    @State private var selectedUserNumber: String?
    @State private var shouldNavigate: Bool = false

    
    @AppStorage("userNumber") var currentUserNumber: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                TabView(selection: $selectedTab) {
                    ChatView(viewModel: ChatviewModel, UserViewModel: viewModel)
                        .tabItem({
                            Image(systemName: "bubble.left.and.bubble.right.fill")
                            Text("Chats")
                        }).tag(0)
                    CallView()
                        .tabItem({
                            Image(systemName: "phone.and.waveform.fill")
                            Text("Calls")
                        }).tag(1)
                    SettingView()
                        .tabItem({
                            Image(systemName: "slider.horizontal.3")
                            Text("Settings")
                        }).tag(2)
                    ContactView(viewModel: viewModel)
                        .tabItem({
                            Image(systemName: "person.circle")
                            Text("Contacts")
                        }).tag(3)
                }
                .accentColor(Color("ColorGreenAdabtive"))
                
            }
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabsView()
    }
}
