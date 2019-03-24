//
//  AuthService.swift
//  Slack2
//
//  Created by Ravi Inder Manshahia on 23/03/19.
//  Copyright © 2019 Ravi Inder Manshahia. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class AuthService {
    
    static let instance = AuthService()
    
    let defaults = UserDefaults.standard
    
    var isLoggedIn : Bool {
        
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    var authToken : String {
        
        get {
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    var userEmail : String {
        
        get {
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    func registerUser(email: String, password: String, completion: @escaping CompletionHandler)
    {
        
        let lowerCasedEmail = email.lowercased()
        
        let body : [String : Any] = [
            "email" : lowerCasedEmail,
            "password" : password
        ]
        
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString { (response) in
            if response.result.error == nil {
                completion(true)
            }
            else{
                completion(false)
                print(response.result.error as Any)
            }
        }
    }
    
    func loginUser(email: String, password: String, completion: @escaping CompletionHandler)
    {
        let lowerCasedEmail = email.lowercased()
        
        
        
        let body : [String : Any] = [
            "email" : lowerCasedEmail,
            "password" : password
        ]
        
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                guard let data = response.data else { return }
               
                do {
                  let json = try JSON(data: data)
                    self.userEmail = json["user"].stringValue
                    self.authToken = json["token"].stringValue
                    self.isLoggedIn = true
                    }
                catch {
                    
                }
                completion(true)
            }
            else
            {
                completion(false)
            }
            
        }
    }
    
    func addUser(avatarName: String, avatarColor: String, email: String, name: String, completion: @escaping CompletionHandler)
    {
        let lowerCaseEmail = email.lowercased()
        let body : [String : Any] = [
            "avatarName" : avatarName,
            "avatarColor" : avatarColor,
            "name" : name,
            "email" : lowerCaseEmail
        ]
   
        Alamofire.request(URL_ADD_USER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER_AUTH).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else {return}
                self.setUserData(data: data)
                completion(true)
            }
            else {
                completion(false)
                print(response.result.error as Any)
            }
        }
        
    }
    
    func findUserByEmail (completion : @escaping CompletionHandler)
    {
        Alamofire.request("\(URL_USER_BY_EMAIL)\(userEmail)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER_AUTH).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                self.setUserData(data: data)
                completion(true)
            }
            else
            {
                completion(false)
                print(response.result.error as Any)
            }
        }
    }
    
    func setUserData( data : Data)
    {
        do {
            let json = try JSON(data: data)
            let id = json["_id"].stringValue
            let avatarName = json["avatarName"].stringValue
            let avatarColor = json["avatarColor"].stringValue
            let email = json["email"].stringValue
            let name = json["name"].stringValue
            UserDataService.instance.setUserData(id: id, avatarColor: avatarColor, avatarName: avatarName, email: email, name: name)
            
        }
        catch{
            
        }
    }
}
