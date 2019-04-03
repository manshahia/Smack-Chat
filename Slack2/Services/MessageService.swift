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
    
    func clearChannels()
    {
        channels.removeAll()
    }
}

