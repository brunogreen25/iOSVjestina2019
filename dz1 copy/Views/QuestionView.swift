//
//  QuestionView.swift
//  dz1
//
//  Created by five on 4/12/19.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import UIKit
protocol MyQuestionViewProtocol : NSObjectProtocol {
    func buttonTapped()
}

protocol CorrectAnswerProtocol : NSObjectProtocol {
    func correctAnswer()
}

class QuestionView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var questionTitle: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var answer1: UIButton!
    @IBOutlet weak var answer2: UIButton!
    @IBOutlet weak var answer3: UIButton!
    @IBOutlet weak var answer4: UIButton!
    var correctAnswer: Int = 0
    var quiz: Quiz?
    var question: Question?
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init(frame: CGRect, quiz: Quiz, question: Question) {
        super.init(frame: frame)
        self.quiz = quiz
        self.question = question
        
        self.translatesAutoresizingMaskIntoConstraints = true
        /*answer1.translatesAutoresizingMaskIntoConstraints = true
        answer2.translatesAutoresizingMaskIntoConstraints = true
        answer3.translatesAutoresizingMaskIntoConstraints = true
        answer4.translatesAutoresizingMaskIntoConstraints = true
        questionTitle.translatesAutoresizingMaskIntoConstraints = true*/
        
        if quiz.questions is [Question]{
            let question = question
            //if (question.answers) != nil{
                questionTitle?.text = question.question
                answer1.setTitle(question.answers[0], for: .normal)
                answer2.setTitle(question.answers[1], for: .normal)
                answer3.setTitle(question.answers[2], for: .normal)
                answer4.setTitle(question.answers[3], for: .normal)
            //}
        }
        
        self.backgroundColor = quiz.category.color
        /*witch quiz.category{
        case .SPORTS:
            self.backgroundColor = quiz.
        case .SCIENCE:
            self.backgroundColor = ImageBackground.science.color
        default:
            self.backgroundColor = ImageBackground.blank.color
        }*/
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("QuestionView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func makeQuestion(question: Question) {
        self.correctAnswer = question.correctAnswer
        DispatchQueue.main.async {
            self.questionTitle.text = question.question
            self.answer1.setTitle(question.answers[0], for: .normal)
            self.answer2.setTitle(question.answers[1], for: .normal)
            self.answer3.setTitle(question.answers[2], for: .normal)
            self.answer4.setTitle(question.answers[3], for: .normal)
           
        }
    }
    @IBAction func buttonOneTapped(_ sender: UIButton) {
        if self.correctAnswer == 0 {
            self.answer1.backgroundColor = UIColor.green
        } else {
            self.answer1.backgroundColor = UIColor.red
        }
    }
    
    @IBAction func buttonTwoTapped(_ sender: UIButton) {
        if self.correctAnswer == 1 {
            self.answer2.backgroundColor = UIColor.green
        } else {
            self.answer2.backgroundColor = UIColor.red
        }
    }
    
    @IBAction func buttonThreeTapped(_ sender: UIButton) {
        if self.correctAnswer == 2 {
            self.answer3.backgroundColor = UIColor.green
        } else {
            self.answer3.backgroundColor = UIColor.red
        }
    }
    @IBAction func buttonFourTapped(_ sender: UIButton) {
        if self.correctAnswer == 3 {
            self.answer4.backgroundColor = UIColor.green
        } else {
            self.answer4.backgroundColor = UIColor.red
        }
    }
}
