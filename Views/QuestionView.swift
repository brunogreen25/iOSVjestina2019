//
//  File.swift
//  QuizzApp
//
//  Created by Five on 4/8/19.
//  Copyright © 2019 BrunoJ. All rights reserved.
//

import Foundation
import UIKit

class QuestionView: UIView {
    
    @IBOutlet weak var labelNaslov: UILabel!
    
    @IBOutlet weak var textViewPitanje: UITextView!
    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var buttonFour: UIButton!
    
    @IBOutlet weak var buttonTwo: UIButton!
    @IBOutlet weak var buttonThree: UIButton!
    
    
    var indexPitanja: Int=0
    var indexKviza: Int=0
    var correctAnswer: Int=0
    var quizzes: [Quiz]=[]
    
    var label: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.purple
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        label = UILabel(frame: CGRect(origin: CGPoint(x: 10, y: 10), size: CGSize(width: 40, height: 40)))
        label?.text = "text"
        label?.backgroundColor = UIColor.blue
        
        if let label = label {
            self.addSubview(label)
        }
    }
    
    func dodajKvizove(_ quizzes: [Quiz], _ index: Int){
        self.quizzes=quizzes
        self.correctAnswer=self.quizzes[index].questions[0].correctAnswer
        self.indexKviza=index
        self.indexPitanja = -1
        sastaviPitanje()
    }
    
    func sastaviPitanje()
    {
        self.indexPitanja+=1
        self.correctAnswer=self.quizzes[indexKviza].questions[self.indexPitanja].correctAnswer
        Thread.sleep(forTimeInterval: 1)
        DispatchQueue.main.async {
            print(self.quizzes[self.indexKviza].questions[self.indexPitanja].questionMark)
            self.labelNaslov.text=self.quizzes[self.indexKviza].questions[self.indexPitanja].questionMark
            self.buttonOne.setTitle(self.quizzes[self.indexKviza].questions[self.indexPitanja].answers[0],for: .normal)
            self.buttonTwo.setTitle(self.quizzes[self.indexKviza].questions[self.indexPitanja].answers[1],for: .normal)
            self.buttonThree.setTitle(self.quizzes[self.indexKviza].questions[self.indexPitanja].answers[2],for: .normal)
            self.buttonFour.setTitle(self.quizzes[self.indexKviza].questions[self.indexPitanja].answers[3],for: .normal)
        }
    }
    
    //jese sa targeton ovo moze spojit u jedan listener??
    @IBAction func buttonOneTapped(_ sender: Any) {
        if correctAnswer==0 {
            self.buttonOne.backgroundColor=UIColor.green
        }else{
            self.buttonOne.backgroundColor=UIColor.red
        }
        sastaviPitanje()
    }
    
    @IBAction func buttonTwoTapped(_ sender: Any) {
        if correctAnswer==1 {
            self.buttonTwo.backgroundColor=UIColor.green
        }else{
            self.buttonTwo.backgroundColor=UIColor.red
        }
        sastaviPitanje()
    }
    
    @IBAction func buttonThreeTapped(_ sender: Any) {
        if correctAnswer==2 {
            self.buttonThree.backgroundColor=UIColor.green
        }else{
            self.buttonThree.backgroundColor=UIColor.red
        }
        sastaviPitanje()
    }
    
    @IBAction func buttonFourTapped(_ sender: Any) {
        if correctAnswer==3 {
            self.buttonFour.backgroundColor=UIColor.green
        }else{
            self.buttonFour.backgroundColor=UIColor.red
        }
        sastaviPitanje()
    }
    
}
