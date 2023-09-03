//
//  HomeView.swift
//  chat
//
//  Created by Imran Abdullah on 26/08/23.
//

import SwiftUI

struct HomeView: View {
    @State var x = UIScreen.main.bounds.width + 20
    var body: some View {
        VStack {
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                VStack {
                    TopbarView(x: $x)
                    TabNavigation()
                    Spacer(minLength: 0)
                }
            }
        }.padding(.top, -40)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
