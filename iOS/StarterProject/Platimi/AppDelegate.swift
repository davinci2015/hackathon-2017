//
//  AppDelegate.swift
//  Platimi
//
//  Created by Božidar on 29/10/2016.
//  Copyright © 2016 Božidar. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{

    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        AppDependencies.sharedInstance.navigationService.pushLaunchViewControllerInWindow(window: self.window!)

        return true
    }


}
