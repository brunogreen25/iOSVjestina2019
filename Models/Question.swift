//
//  File.swift
//  QuizzApp
//
//  Created by Five on 4/6/19.
//  Copyright © 2019 BrunoJ. All rights reserved.
//

import Foundation
import UIKit
class Question{
    
    let id: Int
    let questionMark: String
    var answers: [String]=[]
    let correctAnswer: Int
    
    init(_ id: Int, _ questionMark: String, _ answers: [String], _ correctAnswer: Int){
        self.id=id
        self.questionMark=questionMark
        //self.answers=answers.map{$0}
        self.answers=answers
        self.correctAnswer=correctAnswer
    }
}

