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
        let topup = TopUpViewController()
        
        topup.tabBarItem.image = UIImage(systemName: "person.fill")
        topup.title = "Topup"
        
        home.tabBarItem.image = UIImage(systemName: "house.fill")
        home.title = "Home"
        
        
        let nav1 = UINavigationController(rootViewController: home)
        let nav2 = UINavigationController(rootViewController: topup)
        
        setViewControllers([nav1, nav2], animated: true)
        

    }
    

}
