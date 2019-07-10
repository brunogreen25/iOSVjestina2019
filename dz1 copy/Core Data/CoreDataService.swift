//
//  CoreDataService.swift
//  dz1
//
//  Created by five on 6/13/19.
//  Copyright © 2019 five. All rights reserved.
//


import Foundation
import UIKit
class CoreDataService {
    
    let persistanceManager=CoreDataManager.shared
    
    func saveToMemory(_ quizzes: [Quiz]) {
        
        
        for q in quizzes {
            //print("Documents Directory: ", FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last ?? "Not Found!")
            createUniqueQuiz(q)
        }
    }
    
    //create Core Data object
    func createUniqueQuiz(_ quiz: Quiz) {
        //save a User to Core Data
        
        if checkForRepetitions(quiz) {
            var db = Quizz(context: self.persistanceManager.context)
            //print(String(describing: type(of: UserEntity().user)), " ", String(describing: User.self))
            db.id=Int32(quiz.id)
            db.descr=quiz.description!
            //enum se sprema ka string
            switch  quiz.category{
            case .SCIENCE:
                db.category="SCIENCE"
            case .SPORTS:
                db.category="SPORTS"
            case .UNKNOWN:
                db.category="UNKNOWN"
            default:
                db.category="UNKNOWN"
            }
            
            db.image=quiz.image!
            db.level=Int32(quiz.level)
            db.title=quiz.title
            for q in quiz.questions {
                db.questions.append(Questionn(String(q!.id), q!.question, String(q!.correctAnswer), q!.answers[0], q!.answers[1], q!.answers[2], q!.answers[3]))
                //
            }
            UserDefaults.standard.set(true, forKey: "changesHappened")
            self.persistanceManager.save()
        }
    }
    
    //provjera da nema duplica
    func checkForRepetitions(_ quiz: Quiz) -> Bool {
        if UserDefaults.standard.bool(forKey: "changesHappened") != true {
            return true
        }
        
        var notFound=true
        let db = try persistanceManager.fetch(Quizz.self)
        db.forEach{
            if Int32(quiz.id)==$0.id {
                notFound=false
            }
        }
        
        return notFound
    }
    
    func getQuizzesFromCD() -> [Quiz] {
        // guard let users=try! persistanceManager.context.fetch(Entity.fetchRequest()) as? [QuizCD] else {return}
        var quizzes=[Quiz]()
        //get quizzes from Core Data
        let db=persistanceManager.fetch(Quizz.self)
        
        var qid: Int
        var qtitle: String
        var qdescription: String?
        var qcategory: Category
        var qlevel: Int
        var qimage: String?
        var qquestions: [Question]=[]
        
        for quiz in db {
            qid=Int(quiz.id)
            qimage=quiz.image
            qlevel=Int(quiz.level)
            qtitle=quiz.title
            qdescription=quiz.descr
            
            switch quiz.category{
            case "SCIENCE":
                qcategory=Category.SCIENCE
            case "SPORTS":
                qcategory=Category.SPORTS
            default:
                qcategory=Category.UNKNOWN
                
            }
            
            for q in quiz.questions {
                var answers=[String]()
                
                answers.append(q.answer1)
                answers.append(q.answer2)
                answers.append(q.answer3)
                answers.append(q.answer4)
                
                qquestions.append(Question(Int(q.id)!, q.questionMark, answers, Int(q.correctAnswer)!)!)
            }
            quizzes.append(Quiz(qid, qtitle, qdescription!, qcategory, qlevel, qimage!, qquestions))
        }
        return quizzes
    }
    
    func deleteQuiz(_ quiz: Quiz) {
        
        let db=self.persistanceManager.fetch(Quizz.self)
        
        for q in db {
            if q.id==Int32(quiz.id) {
                persistanceManager.delete(q)
            }
        }
        
        db.forEach{print($0.id, " ", $0.questions[0].answer1)}
    }
}
