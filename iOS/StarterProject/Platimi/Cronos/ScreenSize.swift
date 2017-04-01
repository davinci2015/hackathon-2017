//
//  ScreenSize.swift
//  Platimi
//
//  Created by Božidar on 31/03/2017.
//  Copyright © 2017 Božidar. All rights reserved.
//

import UIKit

enum UIUserInterfaceIdiom : Int {
    case unspecified
    case phone
    case pad
}

class ScreenSize {
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenMaxLength = max(ScreenSize.screenWidth, ScreenSize.screenHeight)
    static let screenMinLength = min(ScreenSize.screenMaxLength, ScreenSize.screenHeight)
}

@objc
class DeviceType : NSObject {
    static let isIPhone4 =  UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.screenMaxLength < 568.0
    static let isIPhone5 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.screenMaxLength == 568.0
    static let isIPhone6 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.screenMaxLength == 667.0
    static let isIPhone6P = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.screenMaxLength == 736.0
    static let is4Inch = UIScreen.main.bounds.width == 568.0
    static let is4InchOrLess = UIScreen.main.bounds.width <= 568.0
    static let isPad = UIDevice.current.userInterfaceIdiom == .pad
}
