//
//  AppDelegate.swift
//  Login-firebase
//
//  Created by Johel Zarco on 17/05/22.
//

import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application : UIApplication, didFinishLaunchingWithOptions launchOptions : [UIApplication.LaunchOptionsKey : Any]?) -> Bool{
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        let controller = ViewController()
        let navController = UINavigationController(rootViewController: controller)
        window?.rootViewController = navController
        FirebaseApp.configure()
        return true
    }
    
}

