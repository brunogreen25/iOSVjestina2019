//
//  LeaderboardService.swift
//  dz1
//
//  Created by five on 6/26/19.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
class LeaderboardService {
    func fetchLeaderboard(quiz_id: Int, urlString: String, completion: @escaping ((NSArray) -> Void)) {
        guard let token = UserDefaults.standard.string(forKey: "accessToken") else { return }
        print(token)
        if let url = URL(string: urlString) {
            
            var request = URLRequest(url: url)
            
            request.httpMethod="GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            request.addValue(token, forHTTPHeaderField: "Authorization")
            
            
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let data = data {
                    do {
                        print(data)
                        let json = try? JSONSerialization.jsonObject(with: data, options: []) as? NSArray
                        if let parseJSON=json{
                            
                            completion(parseJSON!)
                        } else {
                            print("error")
                        }
                        
                    } /*catch {
                        print("error1")
                    }*/
                } else {
                    print("error2")                }
            }
            dataTask.resume()
        } else {
            print("error3")
        }
    }
}
