//
//  Pokemon.swift
//  Platimi
//
//  Created by Božidar on 28/03/2017.
//  Copyright © 2017 Božidar. All rights reserved.
//

import Foundation

class Pokemon {
    var name: String?
    var url: String?

    init(name: String?, url: String?) {
        self.name = name ?? ""
        self.url = url ?? ""
    }

}
