//
//  ViewController.swift
//  dz1
//
//  Created by five on 4/8/19.
//  Copyright © 2019 five. All rights reserved.
//


import UIKit
import CoreData

class InitialViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var leaderboardButton: UIButton!
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuizDescription", for: indexPath) as! QuizDescription
        
        let urlString = "https://iosquiz.herokuapp.com/api/quizzes"
        let quizService = Service()
        quizService.fetchQuiz(urlString: urlString) { (dict) in
            DispatchQueue.main.async {
                if let dict = dict {
                    ///ode nebi nista tribalo ic
                    ///self.labelNaslov.isHidden = true
                    
                    var celije: Array<Array<Quiz>> = []
                    var sportski_kvizovi: Array<Quiz> = []
                    var science_kvizovi: Array<Quiz> = []
                    
                    let pickedQuiz = self.quizzes
                    
                    for quiz in pickedQuiz{
                        if quiz.category == Category.SCIENCE{
                            science_kvizovi.append(quiz)
                        }
                        else{
                            sportski_kvizovi.append(quiz)
                        }
                    }
                    celije.append(sportski_kvizovi);
                    celije.append(science_kvizovi);
                    self.data.removeAll()
                    self.data.append(sportski_kvizovi);
                    self.data.append(science_kvizovi);
                    
                    
                    let thiscell:Quiz = (celije[indexPath.section])[indexPath.row]
                    
                    var razina: String=""
                    for _ in 0...thiscell.level{
                        razina+="*"
                    }
                    cell.titleLabel.text = thiscell.title
                    cell.difficultyLabel.text = razina
                    cell.quizDescription.text = thiscell.description as? String
                    
                    self.fetchImage(thiscell, cell.quizImageView)
                    
                    
                }
            }
        }
        
        return cell
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var FetchButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var FunFactLabel: UILabel!
    //@IBOutlet weak var QuizLabel: UILabel!
    //@IBOutlet weak var ImageFrame: UIImageView!
    //@IBOutlet weak var QuestionViewContainer: UIView!
    var quizzes: [Quiz] = []
    var quizSize: Int?
    var number = 0
    var reachability: Reachability?
    
    /*@IBAction func leaderboardTapped(_ sender: Any) {
        let nextView = LeaderboardViewController()
        nextView.indexPath = indexPath
        nextView.categories = sections
        nextView.quizzes = data
        self.navigationController?.pushViewController(nextView, animated: true)
    }*/
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        self.reachability = Reachability.init()
        
        if (self.reachability!.connection) != .none {
            self.fetchQuiz()
        } else {
            let CDService = CoreDataService()
            self.quizzes = CDService.getQuizzesFromCD()
        }
        Thread.sleep(forTimeInterval: 1)
        if let size = self.quizSize {
            number = chooseIndex(size: size)
        }
        if self.quizzes.count > 0 {
            //fetchImageAddTitle()
            //addQuestionView()
            let nbas = countNBA()
            setFunFact(counter: nbas)
            
        }
        print("tap")
    }
    
    func chooseIndex(size: Int) -> Int{
        return Int.random(in: 0 ..< size)
    }
    
    func fetchQuiz() {
        let urlString = "https://iosquiz.herokuapp.com/api/quizzes"
        let myService = Service()
        self.quizzes.removeAll()
        
        // Ta funckija prima string s kojeg treba dohvatiti sadrzaj (json drzave) i blok koda koji zelimo da se izvrsi kada se dohvati taj sadrzaj
        myService.fetchQuiz(urlString: urlString) { (quiz) in
            
            //DispatchQueue.main.async {
            if let quiz = quiz {
                self.quizzes += [quiz]
                //self.QuizLabel.backgroundColor = quiz.category.color
                // self.QuizLabel.text = quiz.title
                print("quiz is fetched")
                self.quizSize = self.quizzes.count
                
                let CDService = CoreDataService()
                CDService.saveToMemory(self.quizzes)
                
                DispatchQueue.main.async {
                    self.tableView.delegate = self
                    self.tableView.dataSource = self
                    self.tableView.reloadData()
                }
            } else {
                DispatchQueue.main.async {
                    //self.QuizLabel.text = "Error"
                    self.errorLabel.isHidden = false
                    self.errorLabel.text = "Error! Unable to connect to server."
                    self.errorLabel.textColor = UIColor.red
                }
                
                
            }
            if let mySize = self.quizSize {
                print(mySize)
            }
            
            //}
            
        }
        
        
    }
    
    func fetchImage(_ quiz: Quiz, _ image: UIImageView) {
        if let imageUrl: String = quiz.image as? String {
            let imageService = ImageService()
            
            imageService.fetchImage(imageUrl: imageUrl) { (image2) in
                DispatchQueue.main.async {
                    image.image = image2
                }
                print("image")
            }
        }
    }
    
    /*func fetchImageAddTitle() {
     let imageService = ImageService()
     if let imageUrl = self.quizzes[self.number].image {
     imageService.fetchImage(imageUrl: imageUrl) {
     (image) in
     DispatchQueue.main.async {
     self.ImageFrame.backgroundColor = self.quizzes[self.number].category.color
     self.ImageFrame.image = image
     self.ImageFrame.layer.contents = image?.cgImage
     
     self.QuizLabel.text = self.quizzes[self.number].title
     self.QuizLabel.backgroundColor = self.quizzes[self.number].category.color
     }
     
     }
     } else {
     print("image unavailable")
     }
     }*/
    
    /*
     func addQuestionView() {
     for v in self.QuestionViewContainer.subviews {
     v.removeFromSuperview()
     }
     let questionView = QuestionView(frame: CGRect(origin: CGPoint(x: 100, y: 100), size: CGSize(width: 100, height: 100)))
     let count = self.quizzes[self.number].questions.count
     let index = Int.random(in: 0 ..< count)
     questionView.makeQuestion(question: self.quizzes[self.number].questions[index]!)
     self.QuestionViewContainer.addSubview(questionView)
     }
     */
    
    func countNBA() -> Int {
        var questions: [String] = []
        for quiz in self.quizzes {
            for quest in quiz.questions {
                questions += [(quest?.question)!]
            }
        }
        let quiz2 =
            self.quizzes.map{
                $0.questions.filter{
                    $0?.question.contains("NBA") ?? false
                    }.count
                }.reduce(0) {$0 + $1}
        
        var counter = 0
        for quest in questions {
            if quest.contains("NBA") {
                counter += 1
            }
        }
        
        return quiz2
        
    }
    
    func setFunFact(counter: Int) {
        DispatchQueue.main.async {
            self.FunFactLabel.text = "The word \"NBA\" came up \(counter) times"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    self.tableView.register(UINib(nibName: "QuizDescription", bundle: nil), forCellReuseIdentifier: "QuizDescription")
        
    }
    
    @objc func test() {
        
    }
    
    var sections: Array<String> = ["Sports", "Science"]
    var data: Array<Array<Quiz>> = []
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextView = QuizViewController()
        nextView.indexPath = indexPath
        nextView.categories = sections
        nextView.quizzes = data
        self.navigationController?.pushViewController(nextView, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 18))
        let label = UILabel(frame: CGRect(x: 10, y: 5, width: tableView.frame.size.width, height: 18))
        label.text = sections[section]
        
        var category = Category.UNKNOWN
        switch sections[section] {
        case "SCIENCE":
            category = Category.SCIENCE
        case "SPORTS":
            category = Category.SPORTS
        default:
            category = Category.UNKNOWN
        }
        view.backgroundColor = category.color
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let urlString = "https://iosquiz.herokuapp.com/api/quizzes"
        let quizService = Service()
        var num = 1
        if section == 0 {num = 2}
        if section == 1 { num = 1 }
        return num
    }
    
    func displayAlertMessage(_ message: String)
    {
        //HOW TO MAKE ALERT POP-UP MINI WINDOW
        let myAlert=UIAlertController(title: "Oops!", message: message, preferredStyle: UIAlertController.Style.alert)
        
        let okAction=UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        
        myAlert.addAction(okAction)
        
        DispatchQueue.main.async {
            self.present(myAlert, animated: true)
        }
    }
    
    /*func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }*/
    /*
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListQuizCell", for: indexPath) as! ListQuizCell
        
        let urlString = "https://iosquiz.herokuapp.com/api/quizzes"
        let quizService = Service()
        quizService.fetchQuiz(urlString: urlString) { (dict) in
            DispatchQueue.main.async {
                if let dict = dict {
                    ///ode nebi nista tribalo ic
                    ///self.labelNaslov.isHidden = true
                    
                    var celije: Array<Array<Quiz>> = []
                    var sportski_kvizovi: Array<Quiz> = []
                    var science_kvizovi: Array<Quiz> = []
                    
                    let pickedQuiz = self.quizzes
                    
                    for quiz in pickedQuiz{
                        if quiz.category == ImageBackground.science{
                            science_kvizovi.append(quiz)
                        }
                        else{
                            sportski_kvizovi.append(quiz)
                        }
                    }
                    celije.append(sportski_kvizovi);
                    celije.append(science_kvizovi);
                    self.data.removeAll()
                    self.data.append(sportski_kvizovi);
                    self.data.append(science_kvizovi);
                    
                    
                    let thiscell:Quiz = (celije[indexPath.section])[indexPath.row]
                    
                    var razina: String=""
                    for _ in 0...thiscell.level{
                        razina+="*"
                    }
                    cell.titleLabel.text = thiscell.title
                    cell.difficultyLevelLabel.text = razina
                    cell.textViewDescription.text = thiscell.description as? String
                    
                    self.fetchImage(thiscell, cell.quizImageView)
                    
                    
                }
            }
        }
        
        return cell
    }*/
    

    


}


