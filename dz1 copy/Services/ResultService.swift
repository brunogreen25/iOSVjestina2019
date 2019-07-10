//
//  ResultService.swift
//  dz1
//
//  Created by five on 6/26/19.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation

class ResultService {
    func fetchResults(urlString: String, quizId: Int, userId: Int, time: TimeInterval, Ncorrect: Int, completion: @escaping ((Any?) -> Void)){
        if let url = URL(string: urlString){
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let parameters = ["quiz_id": quizId,"user_id": userId,"time": time,"no_of_correct": Ncorrect] as [String : Any]
            
            do {
                let token = UserDefaults.standard.string(forKey: "token")
                
                request.setValue(token, forHTTPHeaderField: "Authorization")
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
                
                
            } catch let error {
                print("greska \(error)!")
            }
            
            let dataTask = URLSession.shared.dataTask(with: request){(data, response, error) in
                if let data = data {
                    do{
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        
                        completion(json)
                        
                        ///stavit cemo da ovako izgleda
                        /*let json = try? JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
                         if let parseJSON=json{
                         
                         let accessToken=parseJSON?["token"] as? String
                         let userId=parseJSON?["user_id"] as? Int
                         
                         completion(accessToken, userId)
                         }*/
                        
                    }catch{
                        completion(nil)
                    }
                } else {
                    completion(nil)
                }
                
                if let resp = response as? HTTPURLResponse {
                    if resp.statusCode == ServerResponse.OK.rawValue {
                        print(ServerResponse.OK)
                    } else {
                        print(resp.statusCode)
                    }
                }else{
                    print(response!)
                }
                
                
            }
            dataTask.resume()
        }else {
            completion(nil)
        }
    }
    
    
    
}
