//
//  SecureAuthTextField.swift
//  Chat
//
//  Created by Imran Abdullah on 22/08/23.
//

import SwiftUI

struct SecureAuthTextField: View {
    var placeHolder: String
    @Binding var text: String
    
    var body: some View {
        VStack {
            ZStack (alignment: .leading) {
                if text.isEmpty {
                    Text(placeHolder)
                        .foregroundColor(.gray)
                }
                
                SecureField("", text: $text)
                    .frame(height: 45)
                    .foregroundColor(Color("text"))
            }
        }
    }}

