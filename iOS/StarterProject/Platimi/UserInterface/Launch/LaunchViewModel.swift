//
//  LaunchViewModel.swift
//  Platimi
//
//  Created by Božidar on 29/10/2016.
//  Copyright © 2016 Božidar. All rights reserved.
//

import Foundation

class LaunchViewModel {
    private let navigationService: NavigationService
    
    init(navigationService: NavigationService) {
        self.navigationService = navigationService
    }
    
    func navigateToLogin() {
        navigationService.pushZekoPeko()
    }
    
}
