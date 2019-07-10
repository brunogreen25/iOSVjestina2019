//
//  Service.swift
//  dz1
//
//  Created by five on 4/8/19.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation


class Service {
    
    func fetchQuiz(urlString: String, completion: @escaping ((Quiz?) -> Void)) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        if let jsonDict = json as? [String: Any] {
                            if let quizzes: [Any] = jsonDict["quizzes"] as? [Any] {
                                for quiz in quizzes {
                                    let quizic = Quiz(json: quiz)
                                    completion(quizic)
                                }
                            } else {
                                completion(nil)
                            }
                        } else {
                            completion(nil)
                        }
                    } catch {
                        completion(nil)
                    }
                    
                    
                } else {
                    completion(nil)
                }
            }
            dataTask.resume()
        } else {
            completion(nil)
        }
        
    }}

