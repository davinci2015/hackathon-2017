//
//  UIColor+Item.swift
//  Platimi
//
//  Created by Božidar on 31/03/2017.
//  Copyright © 2017 Božidar. All rights reserved.
//

import UIKit

extension UIColor {
    static func colorForUnitNumber(_ itemNumber: UInt) -> UIColor {
        switch itemNumber {
        case 1 :
            return UIColor(colorLiteralRed: 240.0/255.0, green: 196.0/255.0, blue: 51.0/255.0, alpha: 1.0)
        case 2 :
            return UIColor(colorLiteralRed: 176.0/255.0, green: 201.0/255.0, blue: 70.0/255.0, alpha: 1.0)
        case 3 :
            return UIColor(colorLiteralRed: 220.0/255.0, green: 72.0/255.0, blue: 39.0/255.0, alpha:1.0)
        case 4 :
            return UIColor(colorLiteralRed: 146.0/255.0, green: 202.0/255.0, blue: 219.0/255.0, alpha: 1.0)
        case 5 :
            return UIColor(colorLiteralRed: 94.0/255.0, green: 160.0/255.0, blue: 211.0/255.0, alpha: 1.0)
        case 6 :
            return UIColor(colorLiteralRed: 54.0/255.0, green: 192.0/255.0, blue: 110.0/255.0, alpha: 1.0)
        case 7 :
            return UIColor(colorLiteralRed: 193.0/255.0, green: 89.0/255.0, blue: 80.0/255.0, alpha: 1.0)
        case 8 :
            return UIColor(colorLiteralRed: 222.0/255.0, green: 185.0/255.0, blue: 117.0/255.0, alpha: 1.0)
        case 9 :
            return UIColor(colorLiteralRed: 113.0/255.0, green: 187.0/255.0, blue: 213.0/255.0, alpha: 1.0)
        case 10 :
            return UIColor(colorLiteralRed: 210.0/255.0, green: 102.0/255.0, blue: 167.0/255.0, alpha: 1.0)
        case 11 :
            return UIColor(colorLiteralRed: 68.0/255.0, green: 135.0/255.0, blue: 192.0/255.0, alpha: 1.0)
        case 12 :
            return UIColor(colorLiteralRed: 69.0/255.0, green: 170.0/255.0, blue: 132.0/255.0, alpha: 1.0)
        case 13 :
            return UIColor(colorLiteralRed: 36.0/255.0, green: 151.0/255.0, blue: 183.0/255.0, alpha:1.0)
        case 14 :
            return UIColor(colorLiteralRed: 154.0/255.0, green: 185.0/255.0, blue: 113.0/255.0, alpha: 1.0)
        case 15 :
            return UIColor(colorLiteralRed: 106.0/255.0, green: 105.0/255.0, blue: 160.0/255.0, alpha: 1.0)
        case 16 :
            return UIColor(colorLiteralRed: 170.0/255.0, green: 130.0/255.0, blue: 207.0/255.0, alpha: 1.0)
        case 17 :
            return UIColor(colorLiteralRed: 109.0/255.0, green: 209.0/255.0, blue: 186.0/255.0, alpha: 1.0)
        case 18 :
            return UIColor(colorLiteralRed: 158.0/255.0, green: 138.0/255.0, blue: 219.0/255.0, alpha: 1.0)
        case 19 :
            return UIColor(colorLiteralRed: 197.0/255.0, green: 74.0/255.0, blue: 89.0/255.0, alpha: 1.0)
        case 20 :
            return UIColor(colorLiteralRed: 248.0/255.0, green: 161.0/255.0, blue: 105.0/255.0, alpha: 1.0)
        default:
            return UIColor.black
        }
    }
}
