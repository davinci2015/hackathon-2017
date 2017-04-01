//
//  DetailsViewController.swift
//  Platimi
//
//  Created by Božidar on 28/03/2017.
//  Copyright © 2017 Božidar. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {


    private var viewModel: DetailsViewModel?

    convenience init(viewModel: DetailsViewModel) {
        self.init()
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
    }







}


