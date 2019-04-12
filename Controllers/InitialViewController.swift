//
//  ViewController.swift
//  QuizzApp
//
//  Created by Five on 4/6/19.
//  Copyright © 2019 BrunoJ. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {
    @IBOutlet weak var imageViewFrontImage: UIImageView!
    @IBOutlet weak var buttonDohvati: UIButton!
    @IBOutlet weak var labelCounter: UILabel!
    @IBOutlet weak var stepperCounter: UIStepper!
    @IBOutlet weak var labelError: UILabel!
    
    @IBOutlet weak var labelNaslov: UILabel!
    
    @IBOutlet weak var labelFunFact: UILabel!
    
    @IBOutlet weak var customViewContainer: UIView!
    var quizzes: [Quiz]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.labelError.isHidden=true
        self.labelNaslov.isHidden=true
        countStepperMaxValue(0)
        self.labelCounter.text="0"
    }
    
    @IBAction func stepperCounterTapped(_ sender: UIStepper) {
        DispatchQueue.main.async {
            self.stepperCounter.minimumValue=0
            self.labelCounter.text=Int(sender.value).description  //description je da samo pritvori u String
        }
    }
    
    func countStepperMaxValue(_ max: Int){
        DispatchQueue.main.async {
            self.stepperCounter.maximumValue=Double(max)
        }
    }
    
    
    @IBAction func buttonDohvatiTapped(_ sender: UIButton) {
        fetchQuizzes()
        Thread.sleep(forTimeInterval: 1.5)
        countStepperMaxValue(quizzes.count-1)
        
        countNBA()
        addUIViews()
        addCustomView()
    }
    
    func addCustomView(){
        let customView = QuestionView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 343, height: 221)))
        if let number=self.labelCounter.text{
            customView.dodajKvizove(self.quizzes,Int(number)!)
        }
        
        self.customViewContainer.addSubview(customView)
    }
    
    func addUIViews(){
        DispatchQueue.main.async {
            self.labelNaslov.text = self.quizzes[Int(self.labelCounter.text!)!].title
            self.labelNaslov.sizeToFit()
            self.labelNaslov.isHidden=false
        
            self.view.backgroundColor=self.quizzes[Int(self.labelCounter.text!)!].category.color
        }
        let frontImageService = FrontImageService()
        
        if let imageString=self.quizzes[Int(self.labelCounter.text!)!].image {
            frontImageService.fetchFrontImage(imageUrlString: imageString)
            { (image) in
                print("setting image")
                DispatchQueue.main.async {
                    self.imageViewFrontImage.image = image
                    self.imageViewFrontImage.layer.contents=image?.cgImage
                    self.view.addSubview(self.imageViewFrontImage)
                }
                print("image set")
            }
        }
    }
    
    func countNBA() {
        var counter: Int=0
        self.quizzes.map({
            $0.questions.map{
                if $0.questionMark.contains("NBA") {
                    counter+=1
                }
            }
        })
        DispatchQueue.main.async {
            self.labelFunFact.text="Imaju \(counter) sa riječi NBA"
        }
        print(quizzes.count)
    }
    
    func fetchQuizzes() {
        self.quizzes.removeAll()
        
        let urlString="https://iosquiz.herokuapp.com/api/quizzes"
        
        let quizService=QuizService()
        
        quizService.fetchQuiz(urlString: urlString) { (quiz) in
            if let quiz = quiz {
                    self.quizzes+=[quiz]
            }else{
                DispatchQueue.main.async {
                    self.labelError.isHidden=false
                    self.labelError.text="Failed to retrieve data from service"
                }
            }
        }
    }
    
}
