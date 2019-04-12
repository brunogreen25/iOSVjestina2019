//
//  File.swift
//  QuizzApp
//
//  Created by Five on 4/7/19.
//  Copyright © 2019 BrunoJ. All rights reserved.
//

import Foundation
import UIKit

class FrontImageService {
    
    func fetchFrontImage(imageUrlString: String, completion: @escaping ((UIImage?) -> Void)){
        if let url = URL(string: imageUrlString) {
            
            let request = URLRequest(url: url)
            
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                if let data = data {
                    let image = UIImage(data: data)
                    completion(image)
                } else {
                    completion(nil)
                }
            }
            
            dataTask.resume()
        } else {
            completion(nil)
        }
    }
}


