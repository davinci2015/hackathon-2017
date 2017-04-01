//
//  QuizFirstViewController.swift
//  Platimi
//
//  Created by Božidar on 31/03/2017.
//  Copyright © 2017 Božidar. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class QuizFirstViewController: UIViewController {
    @IBOutlet weak var incorectFirst: UIImageView!

    private let animationDuration: TimeInterval = 1.0

    @IBOutlet weak var correct: UIImageView!

    @IBOutlet weak var firstButton: UIButton!

    @IBOutlet weak var forthButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var incorrectForth: UIImageView!
    @IBOutlet weak var incorrectThird: UIImageView!

    @IBOutlet weak var thirdButton: UIButton!

    fileprivate var navigationService: NavigationService?

    convenience init(navigationService: NavigationService) {
        self.init()
        self.navigationService = navigationService
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setStyle(image: firstButton)
        setStyle(image: secondButton)
        setStyle(image: thirdButton)
        setStyle(image: forthButton)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.incorectFirst.alpha = 0
        self.incorrectThird.alpha = 0
        self.incorrectForth.alpha = 0
        self.correct.alpha = 0
    }

    @IBAction func firstTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            self.incorectFirst.alpha = 1
            self.incorrectThird.alpha = 0
            self.incorrectForth.alpha = 0
            self.correct.alpha = 0
        }
    }


    @IBAction func secondTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            self.incorectFirst.alpha = 0
            self.incorrectThird.alpha = 0
            self.incorrectForth.alpha = 0
            self.correct.alpha = 1
        }

         Timer.scheduledTimer(timeInterval: self.animationDuration, target: self, selector: #selector(self.correctAnswer), userInfo: nil, repeats: false)
    }

    func correctAnswer() {
        navigationService?.pushSpeechRecognition()
    }

    @IBAction func thirdTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            self.incorectFirst.alpha = 0
            self.incorrectThird.alpha = 1
            self.incorrectForth.alpha = 0
            self.correct.alpha = 0

        }
    }
    @IBAction func forthTapped(_ sender: Any) {
        self.incorectFirst.alpha = 0
        self.incorrectThird.alpha = 0
        self.incorrectForth.alpha = 1
        self.correct.alpha = 0

    }
    func setStyle(image: UIButton) {
        image.layer.cornerRadius = DeviceType.isPad ? 4.0 : 2.0
        image.layer.shadowColor = UIColor.black.withAlphaComponent(0.18).cgColor
        image.layer.shadowOffset = CGSize(width: 0, height: 8.0)
        image.layer.shadowRadius = 8.0
        image.layer.shadowOpacity = 1.0
        image.layer.masksToBounds = false
        image.layer.rasterizationScale = UIScreen.main.scale
        image.layer.shouldRasterize = true
    }

}
