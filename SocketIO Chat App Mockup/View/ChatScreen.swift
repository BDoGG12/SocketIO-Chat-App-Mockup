//
//  ChatScreen.swift
//  SocketIO Chat App Mockup
//
//  Created by Ben Do on 2/15/21.
//

import SwiftUI

struct ChatScreen: View {
    @StateObject private var service = SocketService()
    @State private var message = ""
    @State private var name = ""
    
    private func onCommit() {
        if !message.isEmpty {
            service.sendMessage(message: message, withname: name)
            message = ""
        }
    }
    
    private func scrollToLastMessage(proxy: ScrollViewProxy) {
        
        if let lastMessage = service.messages.last {
            withAnimation(.easeOut(duration: 0.4)) {
                proxy.scrollTo(lastMessage.name, anchor: .bottom)
            }
        }
    }
    
    //MARK: - Body
    
    var body: some View {
        VStack {
            ScrollView {
                ScrollViewReader { proxy in // 1
                    LazyVStack(spacing: 8) {
                        
                    }

            }
            HStack {
                TextField("Message", text: $message, onEditingChanged: {_ in }, onCommit: onCommit)
                    .padding(10)
                    .background(Color.secondary.opacity(0.1))
                    .cornerRadius(5)
                Button(action: onCommit) {
                    Image(systemName: "arrowshape.turn.up.right")
                        .font(.system(size: 15))
                }
                .padding()
                .disabled(message.isEmpty)
            }
        }
        .onAppear(perform: {
            service.establishConnection()
        })
        .onDisappear(perform: {
            service.closeConnection()
        })
    }
}
}

//MARK: - ChatScreen Preview

struct ChatScreen_Previews: PreviewProvider {
    static var previews: some View {
        ChatScreen()
    }
}
