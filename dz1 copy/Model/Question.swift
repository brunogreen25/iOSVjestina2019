//
//  Question.swift
//  dz1
//
//  Created by five on 4/8/19.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation


class Question{
    
    let id: Int
    let question: String
    let answers: [String]
    let correctAnswer: Int
    
    init?(_ idLocal: Any, _ questionLocal: Any, _ answersLocal: Any, _ correctAnswerLocal: Any) {
           if let iL = idLocal as? Int,
            let qL = questionLocal as? String,
            let aL = answersLocal as? [String],
            let caL = correctAnswerLocal as? Int {
                self.id = iL
                self.question = qL
                self.correctAnswer = caL
                self.answers = aL
        } else {
            return nil
        }
        
    }
        
        
}
