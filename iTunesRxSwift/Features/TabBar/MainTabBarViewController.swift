//
//  MainTabBarViewController.swift
//  iTunesRxSwift
//
//  Created by Minho on 4/6/24.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
     
        let todayVC = TodayViewController()
        let gamesVC = GamesViewController()
        let appsVC = AppsViewController()
        let appleArcadeVC = AppleArcadeViewController()
        let searchVC = SearchviewController()
        
        todayVC.title = "투데이"
        todayVC.tabBarItem.image = UIImage(systemName: "doc.text.image")
        
        gamesVC.title = "게임"
        gamesVC.tabBarItem.image = UIImage(systemName: "gamecontroller")
        
        appsVC.title = "앱"
        appsVC.tabBarItem.image = UIImage(systemName: "square.stack.3d.up.fill")
        
        appleArcadeVC.title = "아케이드"
        appleArcadeVC.tabBarItem.image = UIImage(systemName: "arcade.stick")
        
        searchVC.title = "검색"
        searchVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        
        let navSearchVC = UINavigationController(rootViewController: searchVC)
        
        setViewControllers([todayVC, gamesVC, appsVC, appleArcadeVC, navSearchVC], animated: true)
    }
}
