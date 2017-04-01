//
//  CronosNavigatioBar.swift
//  Platimi
//
//  Created by Božidar on 29/10/2016.
//  Copyright © 2016 Božidar. All rights reserved.
//

import UIKit

class CronosNavigatioBar: UINavigationBar {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
        barTintColor = UIColor.elementPrimaryBackgroundColor()
        tintColor = UIColor.tertiaryColor()
        //titleTextAttributes = [ NSFontAttributeName : UIFont.h2() ]
        setBackgroundImage(UIImage(), for: .default)
        shadowImage = UIColor.primaryBackgroundColor().toImage(size: CGSize(width: 1.0, height: 1.0))
        isTranslucent = false
        
        let backBtn = UIImage(named: "back")?.withRenderingMode(.alwaysTemplate)
        UINavigationBar.appearance().backIndicatorImage = backBtn
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = backBtn
//        UIBarButtonItem.appearance().setTitleTextAttributes(
//            [NSFontAttributeName: UIFont.Onboarding.navigationButtonNext()], for: .Normal)
    }

}
