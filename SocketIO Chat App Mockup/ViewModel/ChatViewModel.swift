//
//  ChatViewModel.swift
//  SocketIO Chat App Mockup
//
//  Created by Ben Do on 2/10/21.
//

import Foundation

final class ChatViewModel {
    
    var arrUsers: KxSwift<[User]> = KxSwift<[User]>([])
    
    func fetchParticipantList(_ name: String) {
        
        SocketService.shared.participantList { [weak self](result: [User]?) in
            
            guard let self = self,
                  let users = result else {
                return
            }
            
            var filterUsers: [User] = users
            
//            Removed login user from list
            if let index = filterUsers.firstIndex(where: {$0.name == name}) {
                filterUsers.remove(at: index)
            }
            
            self.arrUsers.value = filterUsers
        }
    }
}
