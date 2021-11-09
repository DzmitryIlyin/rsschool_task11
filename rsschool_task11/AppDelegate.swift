//
//  AppDelegate.swift
//  rsschool_task11
//
//  Created by dzmitry ilyin on 9/10/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        //        let rootController = GameState.sharedInstance.gameCondition == .inProgress ? GameViewController() : NewGameViewController()
        let navController = UINavigationController(rootViewController: RocketMainViewController())
        navController.navigationBar.barTintColor = .queenBlue
        navController.navigationBar.isTranslucent = false
        //        navController.navigationBar.setValue(true, forKey: "hidesShadow")
        //
        window.rootViewController = navController
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
    }
    
}

