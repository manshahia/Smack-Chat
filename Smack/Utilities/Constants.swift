//
//  Constants.swift
//  Smack
//
//  Created by Ravi Inder Manshahia on 18/02/19.
//  Copyright © 2019 Ravi Inder Manshahia. All rights reserved.
//

import Foundation


typealias CompletionHandler = (_ success: Bool) -> ()

//URL Constants
let BASE_URL = "https://appychatchatrav.herokuapp.com/"
let URL_REGISTER = "\(BASE_URL)account/register"

//UserDefaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

//Segues
let TO_LOGIN_VC = "toLoginVC"
let TO_NEW_ACCOUNT_VC = "toNewAccount"
let UNWIND_TO_CHANNELVC = "unwindToChannelVC"
