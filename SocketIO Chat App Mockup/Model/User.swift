//
//  User.swift
//  SocketIO Chat App Mockup
//
//  Created by Ben Do on 2/9/21.
//

import Foundation
import Combine


struct User: Codable {
    
    var id: String?
    var isConnected: Bool?
    var name: String?
    
}
