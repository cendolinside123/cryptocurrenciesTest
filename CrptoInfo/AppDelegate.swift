//
//  AppDelegate.swift
//  CrptoInfo
//
//  Created by Mac on 04/01/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow()
        let newsVC = ListCoinViewController()
        let nav = UINavigationController(rootViewController: newsVC)
        nav.navigationBar.barTintColor = .white
        
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        return true
    }


}

