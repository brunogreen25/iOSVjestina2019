//
//  File.swift
//  QuizzApp
//
//  Created by Five on 4/7/19.
//  Copyright © 2019 BrunoJ. All rights reserved.
//

import Foundation
import UIKit

enum ImageBackground {
    
    case sports(UIColor)
    case science(UIColor)
    case blank(UIColor)
    
    var color: UIColor {
        switch self {
        case .sports:
            return UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha:1.0)
        case .science:
            return UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0)
        case .blank:
            return UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
}

