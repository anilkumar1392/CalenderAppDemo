//
//  AppDelegate.swift
//  Demo1
//
//  Created by mac on 30/05/21.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigation : UINavigationController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setupRootNavigation()
        configureNavigation()
        return true
    }

    func setupRootNavigation(){
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = CalenderViewComposer.viewComposedWith()
        navigation = UINavigationController(rootViewController: vc)
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    }
    
    func configureNavigation(){
        navigation?.isNavigationBarHidden = true
    }
}

