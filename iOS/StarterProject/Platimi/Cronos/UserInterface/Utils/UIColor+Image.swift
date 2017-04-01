//
//  UIColor+Image.swift
//  Platimi
//
//  Created by Božidar on 29/10/2016.
//  Copyright © 2016 Božidar. All rights reserved.
//

import UIKit
import Foundation
import CoreGraphics

extension UIColor {
    
    func toImage(size: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, true, UIScreen.main.scale)
        self.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
}
