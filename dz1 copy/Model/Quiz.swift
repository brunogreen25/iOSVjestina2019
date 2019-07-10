//
//  File.swift
//  dz1
//
//  Created by five on 4/8/19.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import UIKit

class Quiz{
    
    let title: String
    let id: Int
    let description: String?
    let category: Category
    let level: Int
    let image: String?
    var questions: [Question?] = []
    
    init(_ id: Int, _ title: String, _ description: String, _ category: Category, _ level: Int, _ image: String, _ questions: [Question]) {
        self.id = id
        self.title = title
        self.description = description
        self.category = category
        self.level = level
        self.image = image
        self.questions = questions
    }
    
    init?(json: Any) {
        
        // ovdje znamo da je ovaj json zapravo dictionary pa ga castamo u [String: Any]
        if let jsonDict = json as? [String: Any],
            let id = jsonDict["id"] as? Int,
            let title = jsonDict["title"] as? String,
            let description = jsonDict["description"] as? String,
            let category = jsonDict["category"] as? String,
            let level = jsonDict["level"] as? Int,
            let image = jsonDict["image"] as? String,
            let questions = jsonDict["questions"] as? [Any] {
            
            self.title = title
            self.id = id
            self.description = description
            switch category {
            case "SPORTS": self.category = Category.SPORTS
            case "SCIENCE": self.category = Category.SCIENCE
            default: self.category = Category.UNKNOWN
                
            }
            self.level = level
            self.image = image
            //var Qquestions: [Question?] = []
            for jJson in questions {
                if let qQuestionDict = jJson as? [String: Any],
                    let qQuestionId = qQuestionDict["id"] as? Int,
                    let qQuestionQuestion = qQuestionDict["question"] as? String,
                    let qQuestionAnswers = qQuestionDict["answers"] as? [String],
                    let qQuestionCorrect = qQuestionDict["correct_answer"] as? Int {
                    
                        self.questions += [Question(qQuestionId, qQuestionQuestion,
                                                    qQuestionAnswers, qQuestionCorrect)]
                    
                } else {
                    return nil
                }
                
            }
            
            
        } else {
            // u slucaju da je nesto poslo krivo, nekakav kljuc je drugaciji ili je tip kriv, vratimo nil
            return nil
        }
        
        
    }
    
}
            
