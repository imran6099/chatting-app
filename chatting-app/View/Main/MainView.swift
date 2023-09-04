//
//  MainVIew.swift
//  chatting-app
//
//  Created by Imran Abdullah on 02/09/23.
//

import SwiftUI

struct MainView: View {
    @State var x = UIScreen.main.bounds.width + 20
    var body: some View {
        VStack {
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                VStack {
                    TabsView()
                    Spacer(minLength: 0)
                }
            }
        }.padding(.top, -40)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
