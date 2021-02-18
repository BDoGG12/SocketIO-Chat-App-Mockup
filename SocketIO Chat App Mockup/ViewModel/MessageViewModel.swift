//
//  MessageViewModel.swift
//  SocketIO Chat App Mockup
//
//  Created by Ben Do on 2/10/21.
//

import Foundation

final class MessageViewModel {
    
    var arrMessage: KxSwift<[ChatMessage]> = KxSwift<[ChatMessage]>([])
    
    func getMessagesFromServer() {
        
        SocketService.shared.getMessage { [weak self] (message: ChatMessage?) in
            
            guard let self = self,
                  let msgInfo = message else {
                return
            }
            
            self.arrMessage.value.append(msgInfo)
        }
    }
    
}
