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
                
                if let access_token = json["access_token"] {
                    print("Access token is: \(access_token)")
                    UserDefaults.standard.set(access_token, forKey: "access_token")
                }
                
                if let refresh_token = json["refresh_token"] {
                    UserDefaults.standard.set(refresh_token, forKey: "refresh_token")
                    UserDefaults.standard.set(true, forKey: "login_token_retrieved")
                    
                }
                
            }
            completion()
        }

    }
    
    
static func getItems(completion: @escaping (_ items: [(name: String, price: Double)]) -> Void) {

        let accessToken = UserDefaults.standard.string(forKey: "access_token") ?? ""
//        print("Access token is: \(accessToken)")
    
        let headers: HTTPHeaders = ["Authorization": "Bearer \(accessToken)"]
    
        Alamofire.request("http://127.0.0.1:5000/items", method: .get, headers: headers).responseJSON { response in
            
            if let json = response.result.value as? [String: AnyObject] {
                
                var itemsToReturn = [(name: String, price: Double)]()   //empty tuple array to store name and price
                
                if let items = json["items"] as? [[String: AnyObject]] {
                    for item in items {
                        itemsToReturn.append((name: item["name"] as! String, price: item["price"] as! Double))
                    }
                }
                
                completion(itemsToReturn)

            } // type-cast json response as [String:AnyObject] closure

        } // Alamofire request closure
    }

//  getItems response
//    {
//    "items": [
//    {
//    "id": 1,
//    "name": "item1",
//    "price": 19.99,
//    "store_id": 2
//    },
//    {
//    "id": 2,
//    "name": "item2",
//    "price": 19.99,
//    "store_id": 2
//    }
//    ]
//    }
    
    
    
}
