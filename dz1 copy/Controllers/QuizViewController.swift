//
//  QuizViewController.swift
//  dz1
//
//  Created by five on 6/24/19.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import UIKit

class QuizViewController: UIViewController {

    @IBOutlet var quizView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var scrollQuestionsView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    var indexPath: IndexPath?
    var categories: Array<String>?
    var quizzes: Array<Array<Quiz>>?
    var views: [QuestionView] = []
    var duration: TimeInterval?
    var start: Date?
    var correctCount: Int?
    
    @IBAction func startButtonTapped(_ sender: Any) {
        self.start = Date.init()
        self.correctCount = 0
        self.startButton.isEnabled = false
        self.scrollQuestionsView.isHidden = false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        views = scrollViews()
        
    }
    
    func setView() {
        let quiz: Quiz = (quizzes![self.indexPath!.section])[self.indexPath!.row]
        DispatchQueue.main.async {
            self.titleLabel.text = quiz.title
        }
        
        let imageService = ImageService()
        let imageURL = quiz.image as! String
        
        imageService.fetchImage(imageUrl: imageURL) { (image) in
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
    
    func scrollViews() -> [QuestionView] {
        UINib(nibName: "QuestionView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! QuestionView
        let quiz = (quizzes![indexPath!.section])[self.indexPath!.row]
        var scrollSubViews: [QuestionView] = []
        for i in 0...(quiz.questions as! [Question]).count - 1{
            let questionView = QuestionView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: view.frame.width, height: view.frame.height)), quiz: quiz, question: (quiz.questions as! [Question])[i])
            scrollSubViews.append(questionView)
        }
        return scrollSubViews
    }
    
    func setScrollView(views: [QuestionView]) {
        scrollQuestionsView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollQuestionsView.contentSize = CGSize(width: view.frame.width * CGFloat(views.count), height: view.frame.height)
        
        for i in 0 ..< views.count {
            views[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            //postavi constrainte
            scrollQuestionsView.addSubview(views[i])
        }
        scrollQuestionsView.isHidden = true
        scrollQuestionsView.isScrollEnabled = false
    }
    
    func correctAnswer() {
        correctCount = correctCount! + 1
    }
    
    func buttonTapped() {
        var point: CGPoint = scrollQuestionsView.contentOffset
        point.x += views[0].frame.width
        scrollQuestionsView.setContentOffset(point, animated: true)
        
        if point.x >= view.frame.width * (CGFloat(views.count)) {
            duration = Date.init().timeIntervalSince(start!)
            startButton.isEnabled = false
            scrollQuestionsView.setContentOffset(CGPoint(x: 0, y:0), animated: true)
            scrollQuestionsView.isHidden = true
            var resultsDisplay: String = "Time: " + String(format: "%.2f", duration!) + "\n" + "Your score is " + String(correctCount!) + "/" + String(views.count) + "!"
            displayAlertMessage(resultsDisplay)
            
            let resultService = ResultService()
            resultService.fetchResults(urlString: "https://iosquiz.herokuapp.com/api/result", quizId: (quizzes![indexPath!.section])[indexPath!.row].id, userId: (UserDefaults.standard.integer(forKey: "username") ), time: duration!, Ncorrect: correctCount!) { _ in }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
                self.navigationController?.popViewController(animated: true)
            })
        }
    }
    
    func displayAlertMessage (_ message: String) {
        //HOW TO MAKE ALERT POP-UP MINI WINDOW
        let myAlert=UIAlertController(title: "Blabla!", message: message, preferredStyle: UIAlertController.Style.alert)
        
        let okAction=UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        
        myAlert.addAction(okAction)
        
        DispatchQueue.main.async {
            self.present(myAlert, animated: true)
        }
    }
    
}
