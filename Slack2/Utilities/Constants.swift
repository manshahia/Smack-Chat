//
//  Constants.swift
//  Slack2
//
//  Created by Ravi Inder Manshahia on 22/03/19.
//  Copyright © 2019 Ravi Inder Manshahia. All rights reserved.
//

import Foundation


typealias CompletionHandler = (_ success: Bool) -> ()

//URL Constants
let BASE_URL = "https://appychatchatrav.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"
let URL_ADD_USER = "\(BASE_URL)user/add"
let URL_USER_BY_EMAIL = "\(BASE_URL)user/byEmail/"
let URL_CHANNELS = "\(BASE_URL)channel"
let URL_GET_MESSAGES = "\(BASE_URL)message/byChannel"

//segues
let TO_LOGIN_SEGUE = "toLogin"
let TO_CREATE_ACCOUNT_SEGUE = "create_Account"
let UNWIND_TO_CHANNEL_VC = "unwindToChannelVC"
let AVATAR_PICKER_SEGUE = "avatarPicker"

//user defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "email"

//Colors
let purplePlaceholder = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 0.4650577911)

//Notifications

let DID_CHANGE_USER_DATA = NSNotification.Name(rawValue: "didChangeUserData")
let NOTIF_CHANNELS_LOADED = NSNotification.Name(rawValue: "channelsLoaded")
let NOTIF_CHANNEL_SELECTED = NSNotification.Name(rawValue: "channelSelected")



let HEADER =  [
    "content-type" : "Application/JSON; charset = utf-8"
]
let HEADER_AUTH = [
    "Authorization" : "Bearer \(AuthService.instance.authToken)",
    "content-type" : "Application/JSON; charset = utf-8"
]
