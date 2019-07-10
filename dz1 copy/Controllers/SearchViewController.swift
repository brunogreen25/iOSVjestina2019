//
//  SearchView.swift
//  dz1
//
//  Created by five on 6/13/19.
//  Copyright © 2019 five. All rights reserved.
//


import Foundation
import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    
    
   
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var quizzes: [Quiz] = []
    var categories: Array<String> = ["SPORTS", "SCIENCE"]
    var cells: Array<Array<Quiz>>=[]
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let quizView = QuizViewController()
        quizView.indexPath = indexPath
        quizView.categories = categories
        quizView.quizzes = cells
        //self.cells.removeAll()
        self.navigationController?.pushViewController(quizView, animated: true)
    }
    
    
    func numberOfSections (in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 18))
        let label = UILabel(frame: CGRect(x: 10, y: 5, width: tableView.frame.size.width, height: 18))
        label.text = categories[section]

        var categColor = Category.UNKNOWN.color
        switch categories[section] {
        case "SCIENCE":
            categColor = Category.SCIENCE.color
        case "SPORTS":
            categColor = Category.SPORTS.color
        default:
            categColor = Category.UNKNOWN.color
        }
        view.backgroundColor = categColor
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /*let urlString = "https://iosquiz.herokuapp.com/api/quizzes"
         let quizService = QuizService()
         
         var broj = 1
         if section == 0 {broj = 2}
         
         quizService.fetchQuiz(urlString: urlString) {(dict) in
         DispatchQueue.main.async {
         if let dict = dict {
         if let pickedQuiz = (dict.data as? Array<Quiz>){
         broj=pickedQuiz.count
         //print(broj)
         }
         }else{broj = 0}
         }
         }*/
        var num=1
        if section == 0 {
            num=2
        }
        
        return num
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuizDescription", for: indexPath) as! QuizDescription
        let urlString = "https://iosquiz.herokuapp.com/api/quizzes"
        let quizService = Service()
        
        quizService.fetchQuiz(urlString: urlString) { (dict) in
            DispatchQueue.main.async {
                if let dict = dict {
                    var celije: Array<Array<Quiz>> = []
                    var sportski_kvizovi: Array<Quiz> = []
                    var science_kvizovi: Array<Quiz> = []
                    
                    for quiz in self.quizzes{
                        if quiz.category==Category.SCIENCE {
                            science_kvizovi.append(quiz)
                        }
                        else{
                            sportski_kvizovi.append(quiz)
                        }
                    }
                    celije.append(sportski_kvizovi);
                    celije.append(science_kvizovi);
                    self.cells.removeAll()
                    self.cells.append(sportski_kvizovi);
                    self.cells.append(science_kvizovi);
                    
                    
                    let thiscell:Quiz = (celije[indexPath.section])[indexPath.row]
                    
                    var razina: String="*"
                    for _ in 0...thiscell.level{
                        razina+="*"
                    }
                    
                    cell.titleLabel.text = thiscell.title
                    cell.difficultyLabel.text = razina
                    cell.quizDescription.text = thiscell.description as? String
                    
                    self.fetchImage(thiscell, cell.imageView!)
                } else{ }
            }
        }
        return cell
    }
    
    
    func fetchImage(_ quiz: Quiz, _ image: UIImageView){
        if let imageUrl: String = quiz.image as? String{
            let imageService = ImageService()
            imageService.fetchImage(imageUrl: imageUrl) { (image2) in
                DispatchQueue.main.async {
                    image.image = image2
                }
                //print("slika")
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.tableView.register(UINib(nibName: "QuizDescription", bundle: nil), forCellReuseIdentifier: "QuizDescription")
    }
    
    @IBAction func buttonClicked(_ sender: Any) {
        self.quizzes.removeAll()
        var searchingWord = self.searchTextField.text
        if let searchingWord = searchingWord {
            let urlString="https://iosquiz.herokuapp.com/api/quizzes"
            let quizService = Service()
            quizService.fetchQuiz(urlString: urlString) { (quizzz) in
                if let quizzz = quizzz {
                    self.quizzes += [quizzz]
                    for quiz in self.quizzes {
                        if let description=quiz.description {
                            if description.lowercased().contains(searchingWord.lowercased()) {
                                    self.quizzes.append(quiz)
                                    continue
                            }
                        }
                        if quiz.title.lowercased().contains(searchingWord.lowercased()) {
                            self.quizzes.append(quiz)
                            continue
                        }
                    }

                } else{
                    //nije uspio dohvatiti
                }
                //ovo ispod se dogadja nakon sta smo dohvatili kvizove
                DispatchQueue.main.async {
                    //_=String(self.quizzes.count)
                }
                
                DispatchQueue.main.async {
                    self.tableView.delegate=self
                    self.tableView.dataSource=self
                    
                    
                    self.tableView.reloadData()
                }
            }
            
        }
    }
    
    
    
    
    
    
    
    
}
