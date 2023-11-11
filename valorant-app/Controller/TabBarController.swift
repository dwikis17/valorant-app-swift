//
//  TabBarController.swift
//  valorant-app
//
//  Created by Dwiki Dwiki on 28/10/23.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabs()
    }
    
    private func setupTabs() {
        let home = HomeControllerWithCardViewController()
        
        home.tabBarItem.image = UIImage(systemName: "house.fill")
        home.title = "Home"
        
        let nav1 = UINavigationController(rootViewController: home)
        
        setViewControllers([nav1], animated: true)
        

    }
    

}
