//
//  HomeViewModel.swift
//  Platimi
//
//  Created by Božidar on 01/11/2016.
//  Copyright © 2016 Božidar. All rights reserved.
//

import Foundation
import RxSwift

class HomeViewModel {

    private var navigationService: NavigationService?
    
    init(navigationService: NavigationService) {
        self.navigationService = navigationService
    }

    func navigateToMasterHome(mode: Mode) {
        self.navigationService?.pushMasterHomeViewController(mode: mode)
    }
}
