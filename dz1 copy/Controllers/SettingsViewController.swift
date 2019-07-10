//
//  SettingsViewController.swift
//  dz1
//
//  Created by five on 6/13/19.
//  Copyright © 2019 five. All rights reserved.
//


import Foundation
import UIKit
class SettingsViewController: UIViewController {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            let username = UserDefaults.standard.string(forKey: "user_id")
            if let username = username {
                self.usernameLabel.text="Dear \(username), "
            }
        }
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        UserDefaults.standard.set(nil, forKey: "accessToken")
        UserDefaults.standard.synchronize()
        
        UserDefaults.standard.set(nil, forKey: "userId")
        UserDefaults.standard.synchronize()
        
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        UserDefaults.standard.synchronize()
        
        //mijenjam root view controller i prikazuje se login ekran
        let applicationDelegate = UIApplication.shared.delegate as! AppDelegate
        applicationDelegate.window?.rootViewController = LoginView()
        applicationDelegate.window?.makeKeyAndVisible()
        
        
    }
    
    
    
}

