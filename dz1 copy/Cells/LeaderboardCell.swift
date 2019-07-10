//
//  LeaderboardCell.swift
//  dz1
//
//  Created by five on 6/27/19.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import UIKit

class LeaderboardCell: UITableViewCell {
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var password: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
