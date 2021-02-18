//
//  SocketIOManager.swift
//  SocketIO Chat App Mockup
//
//  Created by Ben Do on 2/7/21.
//

import SocketIO
import Foundation
import Combine
import UIKit

let host = "ws://localhost:3000"
let connectedUser = "connectUser"
let userList = "userList"
let exitUser = "exitUser"

final class SocketService: ObservableObject {
    
    static let shared = SocketService()
    
    private var manager: SocketManager?
    private var socket: SocketIOClient?
    
    @Published private(set) var messages: [ChatMessage] = []
    
    init() {
        configureSocketClient()
    }
    
    private func configureSocketClient() {
        
        guard let url = URL(string: host) else {
            return
        }
        
        manager = SocketManager(socketURL: url, config: [.log(true), .compress])
        
        
        guard let manager = manager else {
            return
        }
        
        socket = manager.socket(forNamespace: "/**********")
    }
    
    func establishConnection() {
        
        guard let socket = manager?.defaultSocket else{
            return
        }
        
        socket.connect()
    }
    
    func closeConnection() {
        
        guard let socket = manager?.defaultSocket else{
            return
        }
        
        socket.disconnect()
    }
    
    func joinChatRoom(name: String, completion: () -> Void) {
        
        guard let socket = manager?.defaultSocket else {
            return
        }
        
        socket.emit(connectedUser, name)
        completion()
    }
        
    func leaveChatRoom(name: String, completion: () -> Void) {
        
        guard let socket = manager?.defaultSocket else{
            return
        }
        
        socket.emit(exitUser, name)
        completion()
    }
    
    func participantList(completion: @escaping (_ userList: [User]?) -> Void) {
        
        guard let socket = manager?.defaultSocket else {
            return
        }
        
        socket.on(userList) { [weak self] (result, ack) -> Void in
            
            guard result.count > 0,
                let _ = self,
                let user = result.first as? [[String: Any]],
                let data = UIApplication.jsonData(from: user) else {
                    return
            }
            
            do {
                let userModel = try JSONDecoder().decode([User].self, from: data)
                completion(userModel)
                
            } catch let error {
                print("Something happen wrong here...\(error)")
                completion(nil)
            }
        }
        
    }
    
    func getMessage(completion: @escaping (_ messageInfo: ChatMessage?) -> Void) {
        
        guard let socket = manager?.defaultSocket else {
            return
        }
        
        socket.on("newChatMessage") { (dataArray, socketAck) -> Void in
            
            var messageInfo = [String: Any]()
            
            guard let name = dataArray[0] as? String,
                let message = dataArray[1] as? String,
                let date = dataArray[2] as? String else{
                    return
            }
            
            messageInfo["name"] = name
            messageInfo["message"] = message
            messageInfo["date"] = date
            
            guard let data = UIApplication.jsonData(from: messageInfo) else {
                return
            }

            do {
                let messageModel = try JSONDecoder().decode(ChatMessage.self, from: data)
                completion(messageModel)
                
            } catch let error {
                print("Something happen wrong here...\(error)")
                completion(nil)
            }
        }
    }
    
    func sendMessage(message: String, withname name: String) {
        
        guard let socket = manager?.defaultSocket else {
            return
        }
        
        socket.emit("chatMessage", name, message)
    }
}

