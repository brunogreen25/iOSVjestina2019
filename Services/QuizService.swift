//
//  File.swift
//  QuizzApp
//
//  Created by Five on 4/6/19.
//  Copyright © 2019 BrunoJ. All rights reserved.
//

import Foundation
class QuizService{
    func fetchQuiz(urlString: String, completion: @escaping ((Quiz?) -> Void)) {
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let data = data {
                    do {
                        
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        
                        //dict je String: JSON od Array JSON-a
                        //quizzes je Array od JSON-a
                        if let dict = json as? [String: Any],
                            let quizzes = dict["quizzes"] as? [Any]{
                            for quizJson in quizzes{
                                let quiz=Quiz(quizJson)
                                completion(quiz)
                            }
                        }else{
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
    }
}
