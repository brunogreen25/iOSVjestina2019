//
//  Category.swift
//  dz1
//
//  Created by five on 4/8/19.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import UIKit

enum Category {
    
    case SPORTS
    case SCIENCE
    case UNKNOWN
    
    var color: UIColor {
        switch self{
        case .SPORTS:
            return UIColor.lightGray
        case .SCIENCE:
            return UIColor.brown
        case .UNKNOWN:
            return UIColor.white
        }
    }
    
}
