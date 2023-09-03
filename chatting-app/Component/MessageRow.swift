//
//  MessageRow.swift
//  chatting-app
//
//  Created by Imran Abdullah on 29/08/23.
//

import SwiftUI

struct MessageRow: View {
    var message: ChatMessage
        @State private var isMessageTapped: Bool = false
        
        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .none
            formatter.timeStyle = .short
            return formatter
        }()

    var body: some View {
            HStack {
                if message.sender == "Me" {
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text(message.content)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(15)

                        if isMessageTapped {
                            HStack {
                                Text(dateFormatter.string(from: message.timestamp))
                                Image(systemName: messageStatusIcon(message.status))
                            }
                            .font(.footnote)
                        }
                    }
                } else {
                    VStack(alignment: .leading) {
                        Text(message.content)
                            .padding()
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(15)

                        if isMessageTapped {
                            Text(dateFormatter.string(from: message.timestamp))
                                .font(.footnote)
                        }
                    }
                    Spacer()
                }
            }
            .padding([.leading, .trailing], 10)
            .onTapGesture {
                isMessageTapped.toggle()
            }
    }

    func messageStatusIcon(_ status: MessageStatus) -> String {
        switch status {
        case .sent:
            return "arrow.up.circle"
        case .delivered:
            return "checkmark.circle"
        case .read:
            return "eye.circle"
        }
    }

}
