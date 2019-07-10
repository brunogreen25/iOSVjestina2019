//
//  LeaderboardView.swift
//  dz1
//
//  Created by five on 6/26/19.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import UIKit

class LeaderboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return self.username.count
    }
    
    var quiz_id = 4
    var username = [String]()
    var scores = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        //self.tableView.register("LeaderboardCell", forCellReuseIdentifier: "")
    }
    
    func fetchData() {
        //https://iosquiz.herokuapp.com/api/quizzes
        let urlString="https://iosquiz.herokuapp.com/api/score?quiz_id="+String(self.quiz_id)
        
        let leaderboardService = LeaderboardService()
        
        leaderboardService.fetchLeaderboard(quiz_id: self.quiz_id ,urlString: urlString) { (podaci) in
            for i in 0...20 {
                if let dict=podaci[i] as? [String:Any] {
                    self.username.append((dict["username"]! as? String)!)
                    self.scores.append((dict["score"]! as? String)!)
                }
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaderboardCell", for: indexPath) as! QuizDescription
        let urlString = "https://iosquiz.herokuapp.com/api/quizzes"
       
        
        
        return cell
        
    }

    
}
