//
//  ChatMessageRow.swift
//  SocketIO Chat App Mockup
//
//  Created by Ben Do on 2/16/21.
//

import SwiftUI

struct ChatMessageRow: View {
    static private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter
    }()
    
    let message: ChatMessage
    let isUser: Bool
    
    var body: some View {
        HStack {
            if isUser {
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(message.name ?? "Jane Doe")
                        .fontWeight(.bold)
                        .font(.system(size: 12))
                    
                    Text(message.date ?? "Invalid Date")
                        .font(.system(size: 10))
                        .opacity(0.7)
                }
                
                Text(message.message ?? "Type a message")
            }
            .foregroundColor(isUser ? .white : .black)
            .padding(10)
            .background(isUser ? Color.blue : Color(white: 0.95))
            .cornerRadius(5)
            
            if !isUser {
                Spacer()
            }
        }
        .transition(.scale(scale: 0, anchor: isUser ? .topTrailing : .topLeading))
    }
}


