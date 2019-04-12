//
//  File.swift
//  QuizzApp
//
//  Created by Five on 4/6/19.
//  Copyright © 2019 BrunoJ. All rights reserved.
//

import Foundation
import UIKit
class Quiz{
    
    //spremi kategorije kao enume
    let id: Int
    let title: String
    let description: String?
    let category: ImageBackground
    let level: Int
    let image: String?
    var questions: [Question]=[]
    
    init?(_ quizJson: Any) {
        
        // ovdje znamo da je ovaj json zapravo dictionary pa ga castamo u [String: Any]
        if let quizPropertiesDict = quizJson as? [String: Any],
            let id=quizPropertiesDict["id"] as? Int,
            let title=quizPropertiesDict["title"] as? String,
            let category=quizPropertiesDict["category"] as? String,
            let level=quizPropertiesDict["level"] as? Int,
            let questions=quizPropertiesDict["questions"] as? [Any]
        {
            self.id=id
            self.title=title
            
            switch category {
            case "SPORTS": self.category=ImageBackground.sports(UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha:1.0))
            case "SCIENCE": self.category=ImageBackground.science(UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0))
            default: self.category=ImageBackground.blank(UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
            }
            
            self.level=level
            
            
            //parsiranje pitanjaa
            for questionJson in questions{
                if let questionDict = questionJson as? [String: Any],
                    let questionId=questionDict["id"] as? Int,
                    let questionQuestionMark=questionDict["question"] as? String,
                    let questionAnswers=questionDict["answers"] as? [String],
                    let questionCorrectAnswer=questionDict["correct_answer"] as? Int
                {
                    self.questions+=[Question(questionId,questionQuestionMark,questionAnswers,questionCorrectAnswer)]
                }else{
                    //nil za questions
                    return nil
                }
            }
        } else {
            //nil za propertyje
            return nil
        }
        
        if let quizPropertiesDict = quizJson as? [String: Any],
           let description=quizPropertiesDict["description"] as? String?,
           let image=quizPropertiesDict["image"] as? String?
        {
            self.description=description
            self.image=image
        }else{
            self.description=nil
            self.image=nil
        }
        
    }
}
