//
//  AppDelegate.swift
//  MusicAlbumApp
//
//  Created by Vladislav Mashkov on 30.11.2021.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let startingVC = StartingViewController()
        let navigationController = UINavigationController(rootViewController: startingVC)
        window?.rootViewController = navigationController
        
        return true
    }
}

