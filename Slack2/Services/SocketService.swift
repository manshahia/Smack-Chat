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
    
    func esstablishConnection()
    {
        socket.connect()
    }
    
    func closeConnection()
    {
        socket.disconnect()
    }
}
