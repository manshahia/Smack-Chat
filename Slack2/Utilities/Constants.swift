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

//segues
let TO_LOGIN_SEGUE = "toLogin"
let TO_CREATE_ACCOUNT_SEGUE = "create_Account"
let UNWIND_TO_CHANNEL_VC = "unwindToChannelVC"
let AVATAR_PICKER_SEGUE = "avatarPicker"

//user defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "email"

