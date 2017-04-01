//
//  AppDependecies.swift
//  Platimi
//
//  Created by Božidar on 29/10/2016.
//  Copyright © 2016 Božidar. All rights reserved.
//

import Foundation

class AppDependencies: NSObject {
    static let sharedInstance = AppDependencies()
    private(set) var navigationService: NavigationService!
    
    override init() {
        super.init()
        self.navigationService = NavigationService(appDependencies: self)
    }
    
    
}
