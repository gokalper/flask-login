//
//  APIClient.swift
//  flask-login
//
//  Created by Ercilasun, Gokalp on 12/25/18.
//  Copyright © 2018 Ercilasun, Gokalp. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIClient {
    
    static func register(withUsername username: String, password: String) {
        print("Sending request")
        let parameters: Parameters = ["username": username, "password": password]
        Alamofire.request("http://127.0.0.1:5000/register", method: .post, parameters: parameters).responseJSON { response in
            if let json = response.result.value {
                print("JSON: \(json)")
            }
        }
    }
    
    static func login(withUsername username: String, password: String, completion : @escaping ()->()) {
        
        UserDefaults.standard.set(false, forKey: "login_token_retrieved")
        
        print("Sending request")
        
        let parameters: Parameters = ["username": username, "password": password]
        Alamofire.request("http://127.0.0.1:5000/login", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            if let json = response.result.value as? [String: AnyObject] {
                
//                print("JSON: \(json)")
                
                if let access_token = json["access_token"] {
                    
                    print("Access token is: \(access_token)")
                    
                    // Save Access Token incase app closes.

                    UserDefaults.standard.set(access_token, forKey: "access_token")
                }
                
                if let refresh_token = json["refresh_token"] {
                   
                    print("Refresh token is: \(refresh_token)")
                    
                    // Save Refresh Token incase app closes.
                    
                    UserDefaults.standard.set(refresh_token, forKey: "refresh_token")
                    
                    // Update UserDefaults if login is successful to perform segue.
                    
                    UserDefaults.standard.set(true, forKey: "login_token_retrieved")
                    
                }
                
            }
            completion()
        }

    }
}
