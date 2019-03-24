//
//  UserDataService.swift
//  Smack
//
//  Created by Ravi Inder Manshahia on 19/02/19.
//  Copyright © 2019 Ravi Inder Manshahia. All rights reserved.
//

import Foundation

class UserDataService {
    
    static var instance = UserDataService()
    
    public private(set) var id = ""
    public private(set) var name = ""
    public private(set) var email = ""
    public private(set) var avatarName = ""
    public private(set) var avatarColor = ""
    
    func createUser(id : String, name : String, email : String, avatarName : String, avatarColor : String)
    {
        self.id = id
        self.name = name
        self.email = email
        self.avatarName = avatarName
        self.avatarColor = avatarColor
    }
    
    func setAvatarName( avatarName : String)
    {
        self.avatarName = avatarName
    }
}
