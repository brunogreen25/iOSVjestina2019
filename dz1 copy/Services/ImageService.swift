//
//  ImageService.swift
//  dz1
//
//  Created by five on 4/11/19.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import UIKit

class ImageService {
    // ova funkcija prima String i blok koda koja prima UIImage?
    // @escaping anotaciju zasada zanemariti
    func fetchImage(imageUrl: String, completion: @escaping ((UIImage?) -> Void)){
        let urlString = imageUrl
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            
            print("creating data task")
    
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                print("fetched image")
                if let data = data {
                    let image = UIImage(data: data)
                    completion(image)
                    print("completion called")
                } else {
                    completion(nil)
                }
            }
            
            print("resuming data task")
            dataTask.resume()
        } else {
            completion(nil)
        }
    }

}
