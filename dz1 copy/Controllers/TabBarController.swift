//
//  TabBarController.swift
//  dz1
//
//  Created by five on 6/13/19.
//  Copyright © 2019 five. All rights reserved.
//


import Foundation
import UIKit
class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TabBarViewController sadrzi 3 UIViewControllera: UINavigationController, SettingsViewController i SearchViewController
        // UINavigationController na svom stogu sadrzi ReviewsViewController
        
        let viewController = InitialViewController()
        viewController.navigationItem.title = "Quiz list"
        // UIViewControlleri imaju property UITabBarItem koji sadrzi podatke koje koristi UITabBarController
        // UITabBarController koristi tabBarItem objekt da bi iscrtao tab za svaki viewController u svom arrayu viewControllera
        
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem = UITabBarItem(title: "Quiz list", image:nil, tag: 0)
        // UIViewControlleri imaju property UINavigationItem koji nije UIView, vec objekt koji sadrzi podatke koje UINavigationController koristi pri iscrtavanju svog UINavigationBar-a
        // npr property 'title' UINavigationBar-a od ovog ReviewsViewController sadrzi naslov koji ce se ispisati u navigationBaru kada se ReviewsViewController pusha na vrh stoga UINavigationControllera (kada se prikaze na ekranu)
        
        ///ZASTO SE OVI TITLE-OVI NE POJAVLJUJU??
        let viewController2=SearchViewController()
        let navigationController2 = UINavigationController(rootViewController: viewController2)
        navigationController2.tabBarItem=UITabBarItem(title: "Search", image: nil, tag: 0)
        navigationController2.navigationItem.title="Search"
        
        let viewController3 = SettingsViewController()
        viewController3.tabBarItem = UITabBarItem(title: "Settings", image: nil, tag: 0)
        viewController3.navigationItem.title="Settings"
        
        self.viewControllers = [navigationController, navigationController2, viewController3]
    }
    
}
