//
//  TopbarView.swift
//  chat
//
//  Created by Imran Abdullah on 26/08/23.
//

import SwiftUI

struct TopbarView: View {
    @Binding var x: CGFloat
    
    var body: some View {
        VStack {
            HStack {
               
                
                Spacer(minLength: 0)
                
                Image("waafi_logo")
                    .resizable()
                    .renderingMode(.template)
                    .scaledToFit()
                    .padding(.trailing)
                    .frame(width: 90, height: 90)
                    .foregroundColor(Color.white)
                
                Spacer(minLength: 0)
                
            } .padding()
             
        }.background(Color("ColorGreenMedium"))
    }
}

