//
//  AppDelegate.swift
//  Shop
//
//  Created by Juan Gestal Romani on 01/06/2019.
//  Copyright © 2019 Juan Gestal Romani. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupTheme()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = SceneManager.shared.goToProductList()
        self.window?.makeKeyAndVisible()
        return true
    }
    
    func setupTheme() {
        if #available(iOS 11.0, *) {
            UINavigationBar.appearance().prefersLargeTitles = true
        }
    }

}

