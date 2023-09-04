//
//  TobView.swift
//  chatting-app
//
//  Created by Imran Abdullah on 02/09/23.
//

import SwiftUI

struct TobView: View {
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

