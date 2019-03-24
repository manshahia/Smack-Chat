//
//  UserDataService.swift
//  Slack2
//
//  Created by Ravi Inder Manshahia on 23/03/19.
//  Copyright © 2019 Ravi Inder Manshahia. All rights reserved.
//

import Foundation

class UserDataService {
    
    static let instance = UserDataService()
    
    public private(set) var id = ""
    public private(set) var avatarColor = ""
    public private(set) var avatarName = ""
    public private(set) var email = ""
    public private(set) var name = ""
    
    func setUserData(id: String, avatarColor : String, avatarName : String, email: String, name : String)
    {
        self.id = id
        self.avatarName = avatarName
        self.avatarColor = avatarColor
        self.email = email
        self.name = name
    }
    
    func setAvatarName( name : String)
    {
        self.avatarName = name
    }
    
    func logoutUser()
    {
        self.id = ""
        self.avatarName = ""
        self.avatarColor = ""
        self.email = ""
        self.name = ""
        AuthService.instance.isLoggedIn = false
        AuthService.instance.authToken = ""
        AuthService.instance.userEmail = ""
    }
}
