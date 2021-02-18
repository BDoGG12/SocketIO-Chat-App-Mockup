//
//  ChatScreen.swift
//  SocketIO Chat App Mockup
//
//  Created by Ben Do on 2/5/21.
//

import Foundation
import Combine


struct ChatMessage: Codable, Hashable {
    var date: String?
    var message: String?
    var name: String?
}
