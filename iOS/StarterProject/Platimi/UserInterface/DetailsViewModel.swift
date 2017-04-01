//
//  DetailsViewModel.swift
//  Platimi
//
//  Created by Božidar on 28/03/2017.
//  Copyright © 2017 Božidar. All rights reserved.
//

import Foundation

class DetailsViewModel {

    private let service = Service.sharedInstance
    private let url: String!

    init(url: String) {
        self.url = url
    }

    func sendRequest() {
        service.sendTestRequestDetails(url: url) { pokemon in

        }
    }
}
