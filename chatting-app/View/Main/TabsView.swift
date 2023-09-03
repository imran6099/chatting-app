//
//  NavigationView.swift
//  chatting-app
//
//  Created by Imran Abdullah on 02/09/23.
//

import SwiftUI

struct TabView: View {
    var body: some View {
        ZStack {
            TabView {
              ChatView()
                .tabItem({
                  Image(systemName: "bubble.left.and.bubble.right.fill")
                  Text("Chats")
                })
              CallView()
                .tabItem({
                  Image(systemName: "phone.and.waveform.fill")
                  Text("Calls")
                })
              SettingView()
                .tabItem({
                  Image(systemName: "slider.horizontal.3")
                  Text("Settings")
                })
            }
            .accentColor(Color("ColorGreenAdabtive"))
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    Button(action: {
                       
                    }, label: {
                        Image(systemName: "bubble.right.fill").renderingMode(
                            .template).resizable().frame(width: 20, height: 20).padding().background(Color("ColorGreenMedium")).foregroundColor(.white)
                            .clipShape(Circle())
                    }
                    )
                }.padding(.trailing, 25)
            }.padding(.bottom, 75)
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabView()
    }
}
