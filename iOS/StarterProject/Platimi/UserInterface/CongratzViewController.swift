//
//  CongratzViewController.swift
//  Platimi
//
//  Created by Božidar on 01/04/2017.
//  Copyright © 2017 Božidar. All rights reserved.
//

import UIKit

class CongratzViewController: UIViewController {

    private let animationDuration: TimeInterval = 2.0

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        Timer.scheduledTimer(timeInterval: self.animationDuration, target: self, selector: #selector(self.finished), userInfo: nil, repeats: false)
    }

    @objc private func finished() {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController];
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 5], animated: true);
    }


    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
