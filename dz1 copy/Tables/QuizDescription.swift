//
//  QuizDescription.swift
//  dz1
//
//  Created by five on 6/27/19.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import UIKit

class QuizDescription: UITableViewCell {
    
    @IBOutlet weak var quizImageView: UIImageView!
    @IBOutlet weak var quizDescription: UITextView!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    

}
