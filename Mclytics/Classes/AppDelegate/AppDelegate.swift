//
//  AppDelegate.swift
//  Mclytics
//
//  Created by Gunjan Raval on 11/05/20.
//  Copyright © 2020 Gunjan Raval. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var open_count = Int()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        open_count =  1
        
        let isSignedIn = ParentClass.sharedInstance.getDataForKey(strKey: REMEMBER_ME_KEY) as? Bool

        if isSignedIn == true {
            ParentClass.sharedInstance.token =  ParentClass.sharedInstance.getDataForKey(strKey: TOKEN_KEY) as? String
            window = UIWindow(frame: UIScreen.main.bounds)
            let mainController = ViewController() as UIViewController
            let navigationController = UINavigationController(rootViewController: mainController)
            navigationController.navigationBar.isTranslucent = false
            navigationController.navigationBar.isHidden = true
            self.window?.rootViewController = navigationController
            self.window?.makeKeyAndVisible()
  
        }
        
//        self.window.safeAreaInsets.bottom;
//        if IS_IPHONE_X_XR_XMAX{
//            ParentClass.sharedInstance.iPhone_X_Top_Padding = (self.window?.safeAreaInsets.top)!
//            ParentClass.sharedInstance.iPhone_X_Bottom_Padding = (self.window?.safeAreaInsets.bottom)!
//        }
//        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

