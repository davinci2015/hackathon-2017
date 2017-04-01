//
//  MaleFemaleViewController.swift
//  Platimi
//
//  Created by Božidar on 01/04/2017.
//  Copyright © 2017 Božidar. All rights reserved.
//

import UIKit
import RxSwift

class MaleFemaleViewController: UIViewController {

    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    fileprivate var navigationService: NavigationService?
    private let disposeBag = DisposeBag()

    convenience init(navigationService: NavigationService) {
        self.init()
        self.navigationService = navigationService
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        maleButton.isEnabled = false
        femaleButton.isEnabled = false
        startWithNativeSpeech()
    }

    // Startam sound
    func startWithNativeSpeech() {
        maleButton.isEnabled = true
        femaleButton.isEnabled = true
//        let nativeSpeech = NativeSpeech.sharedInstance
//        nativeSpeech.playSound(soundPlay: .tutorialFirst)
//
//        nativeSpeech.soundFinished.filter{$0}.subscribe(onNext: { [weak self] finished in
//            self?.maleButton.isEnabled = true
//            self?.femaleButton.isEnabled = true
//        }).addDisposableTo(disposeBag)
    }


    @IBAction func maleButtonTapped(_ sender: Any) {
        CronosUserDefaults().saveChildType(value: .male)
        navigationService?.pushHomeViewController()
    }

    @IBAction func femaleButtonTapped(_ sender: Any) {
        CronosUserDefaults().saveChildType(value: .female)
        navigationService?.pushHomeViewController()
    }


}
