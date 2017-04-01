//
//  CronosUserDefaults.swift
//  Platimi
//
//  Created by Božidar on 31/03/2017.
//  Copyright © 2017 Božidar. All rights reserved.
//

import Foundation

enum ChildType: String {
    case male = "male"
    case female = "female"
}

class CronosUserDefaults {

    private let childTypeKey = "childType"

    func saveChildType(value: ChildType) {
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(value.rawValue, forKey: childTypeKey)
    }

    func getChildType() -> String? {
        let userDefaults = UserDefaults.standard
        return userDefaults.value(forKey: childTypeKey) as? String
    }

    

}
