//
//  MessageService.swift
//  Slack2
//
//  Created by Ravi Inder Manshahia on 24/03/19.
//  Copyright © 2019 Ravi Inder Manshahia. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService
{
    static let instance = MessageService()
    
    var channels = [Channel]()
    var messages = [Message]()
    var selectedChannel : Channel?
    func getChannels(completion : @escaping CompletionHandler)
    {
        
        
        Alamofire.request(URL_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER_AUTH).responseJSON { (response) in
            
            if response.result.error == nil
            {
                guard let data = response.data else { return }
                
                do {
                    if let json = try JSON(data: data).array
                    {
                        for item in json
                        {
                            let name = item["name"].stringValue
                            let id = item["_id"].stringValue
                            let description = item["description"].stringValue
                        
                            let channel = Channel(id: id, name: name, description: description)
                            self.channels.append(channel)
                        }
                        NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil)
                        completion(true)
                    }
                }
                catch
                {
                    print(error)
                }
            }
            else
            {
                completion(false)
            }
        }
    }

    func getAllMessages(channelID : String, completion: @escaping CompletionHandler)
    {
        print("URL : \(URL_GET_MESSAGES)\(channelID)")
        Alamofire.request("\(URL_GET_MESSAGES)\(channelID)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER_AUTH).responseJSON { (response) in
            
            if response.result.error == nil
            {
                guard let data = response.data else {return}
                do
                {
                    if let json = try JSON(data: data).array
                    {
                        for item in json
                        {
                            let id = item["_id"].stringValue
                            let messageBody = item["messageBody"].stringValue
                            let chanelID = item["channelId"].stringValue
                            let userName = item["userName"].stringValue
                            let userAvatar = item["userAvatar"].stringValue
                            let userAvatarColor = item["userAvatarColor"].stringValue
                            let timeStamp = item["timeStamp"].stringValue
                            
                            let message = Message(id: id, messageBody: messageBody, channelId: chanelID, userName: userName, userAvatar: userAvatar, userAvatarColor: userAvatarColor, timeStamp: timeStamp)
                            
                            
                            
                            
                            self.messages.append(message)
                        }
                    }
                    
                }
                catch
                {
                    
                }
               completion(true)
            }
            else
            {
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
    }
    
    func clearMessages()
    {
        messages.removeAll()
    }
    func clearChannels()
    {
        channels.removeAll()
    }
}

