//
//  ContentView.swift
//  chatting-app
//
//  Created by Imran Abdullah on 29/08/23.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false

    var body: some View {
        Group {
               if isLoggedIn {
                   MainView().onAppear {
                       UserChatViewModel().checkAndAddMockUsers()
                   }
               } else {
                   LoginView()
               }
           }
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
