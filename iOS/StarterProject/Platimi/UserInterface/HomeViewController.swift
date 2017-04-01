//
//  HomeViewController.swift
//  Platimi
//
//  Created by Božidar on 01/11/2016.
//  Copyright © 2016 Božidar. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    
    private var viewModel: HomeViewModel?
    private var disposeBag = DisposeBag()

    @IBOutlet weak var btnStory: UIButton!
    @IBOutlet weak var btnQuiz: UIButton!

    convenience init(viewModel: HomeViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        connectWithViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    private func connectWithViewModel() {

        btnStory.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.viewModel?.navigateToMasterHome(mode: Mode.story)
        }).addDisposableTo(disposeBag)

        btnQuiz.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.viewModel?.navigateToMasterHome(mode: Mode.quiz)
        }).addDisposableTo(disposeBag)
    }



}


