//
//  SocketService.swift
//  Slack2
//
//  Created by Ravi Inder Manshahia on 03/04/19.
//  Copyright © 2019 Ravi Inder Manshahia. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {

    static let instance = SocketService()
    
    let manager : SocketManager
    let socket : SocketIOClient
    
    override init()
    {
        self.manager = SocketManager(socketURL: URL(string: BASE_URL)!)
        self.socket = manager.defaultSocket
        super.init()

    }
    
    func addChannel(name : String, desc: String, completion: @escaping CompletionHandler)
    {
        socket.emit("newChannel", name,desc)
        completion(true)
    }
    
    func getChannel(completion : @escaping CompletionHandler)
    {
        socket.on("channelCreated") { (channelArray, ack) in
            guard let channelName = channelArray[0] as? String else {return}
            guard let channelDesc = channelArray[1] as? String else {return}
            guard let channelID = channelArray[2] as? String else {return}
            
            let channel = Channel(id: channelID, name: channelName, description: channelDesc)
            MessageService.instance.channels.append(channel)
            completion(true)
        }
    }
    
    func sendMessage(messageBody : String, userId: String, channelID: String, completion: @escaping CompletionHandler)
    {
        let user = UserDataService.instance
        socket.emit("newMessage", messageBody, userId, channelID, user.email,user.avatarName, user.avatarColor)
        completion(true)
    }
    
    func getChatMessage(completion : @escaping CompletionHandler)
    {
        socket.on("messageCreated") { (dataArray, ack) in
            guard let messageBody = dataArray[0] as? String else {return}
            guard let channelID = dataArray[2] as? String else {return}
            guard let userName = dataArray[3] as? String else {return}
            guard let userAvatar = dataArray[4] as? String else {return}
            guard let userAVatarColor = dataArray[5] as? String else {return}
            guard let id = dataArray[6] as? String else {return}
            guard let timeStamp = dataArray[7] as? String else {return}
            
            if channelID == MessageService.instance.selectedChannel?.id && AuthService.instance.isLoggedIn
            {
                let newMessage = Message(id: id, messageBody: messageBody, channelId: channelID, userName: userName, userAvatar: userAvatar, userAvatarColor: userAVatarColor, timeStamp: timeStamp)
                MessageService.instance.messages.append(newMessage)
                completion(true)
            }
            else
            {
                completion(false)
            }
        }
    }
    
    func esstablishConnection()
    {
        socket.connect()
    }
    
    func closeConnection()
    {
        socket.disconnect()
    }
}
