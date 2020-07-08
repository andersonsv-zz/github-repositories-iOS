//
//  AppDelegate.swift
//  githubrepositories
//
//  Created by Anderson Vieira on 01/07/20.
//  Copyright © 2020 Vieira. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if let window = window {
            let repositoryViewController = RepositoryViewController()
            repositoryViewController.reactor = RepositoryViewReactor()
            window.rootViewController = UINavigationController(rootViewController: repositoryViewController)
            window.makeKeyAndVisible()
        }
        
        return true
    }
}

