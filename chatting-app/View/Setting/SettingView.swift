//
//  SettingView.swift
//  chatting-app
//
//  Created by Imran Abdullah on 02/09/23.
//

import SwiftUI

struct SettingView: View {
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @AppStorage("userNumber") var userNumber: String = ""
    
    var body: some View {
        VStack {
            Button(action: {
                self.isLoggedIn = false
                self.userNumber = ""
            }, label: {
                Text("Logout")
            })
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
