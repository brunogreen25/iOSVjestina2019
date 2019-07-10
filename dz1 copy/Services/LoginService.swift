//
//  LoginService.swift
//  dz1
//
//  Created by five on 6/13/19.
//  Copyright © 2019 five. All rights reserved.
//


import Foundation

class LoginService {
    
    func fetchLogin(username: String, password: String, urlString: String, completion: @escaping ((String?, Int?) -> Void)) {
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let userData = ["username": username, "password": password]
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: userData)
                
            } catch let error {
                print("Error: \(error)")
                completion(nil, nil)
            }
            
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let data = data {
                    do {
                        
                        let json = try? JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
                        if let jsonDict = json{
                            
                            let accessToken = jsonDict?["token"] as? String
                            let userId = jsonDict?["user_id"] as? Int
                            
                            completion(accessToken, userId)
                        }
                        
                   } //catch _ {
                     //   completion(nil, nil)
                   // }
                } else {
                    completion(nil, nil)
                }
            }
            dataTask.resume()
        } else {
            completion(nil, nil)
        }
    }
    
}
