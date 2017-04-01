//
//  LaunchViewController.swift
//  Platimi
//
//  Created by Božidar on 29/10/2016.
//  Copyright © 2016 Božidar. All rights reserved.
//

import UIKit
import Foundation

class LaunchViewController: UIViewController {
    private let animationDuration: TimeInterval = 1.0
    private var viewModel: LaunchViewModel!
    
    @IBOutlet weak var image: UIImageView!
    convenience init(viewModel: LaunchViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animateFavoriteButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    @objc private func splashFinished() {
        self.viewModel.navigateToLogin()
    }

    func animateFavoriteButton() {

        UIView.animateKeyframes(withDuration: 0.65, delay: 0, options: [.calculationModeCubicPaced, .allowUserInteraction], animations: {

            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.2, animations: {
                self.image.transform = CGAffineTransform(scaleX: 1, y: 1)
            })

            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.2, animations: {
                self.image.transform = CGAffineTransform(scaleX: 1.25, y: 0.75)
            })

            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.2, animations: {
                self.image.transform = CGAffineTransform(scaleX: 0.75, y: 1.25)
            })

            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.2, animations: {
                self.image.transform = CGAffineTransform(scaleX: 1.15, y: 0.85)
            })

            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.2, animations: {
                self.image.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
            
        }, completion: { _ in
            Timer.scheduledTimer(timeInterval: self.animationDuration, target: self, selector: #selector(self.splashFinished), userInfo: nil, repeats: false)
            UINavigationBar.appearance().tintColor = UIColor.black
        })
    }

}
