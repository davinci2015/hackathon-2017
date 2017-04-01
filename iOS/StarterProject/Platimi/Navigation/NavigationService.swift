//
//  NavigationService.swift
//  Platimi
//
//  Created by Božidar on 29/10/2016.
//  Copyright © 2016 Božidar. All rights reserved.
//

import UIKit

enum Mode {
    case story
    case quiz
}

class NavigationService: NSObject {

    
    private let appDependencies: AppDependencies
    let rootNavigationController = UINavigationController(navigationBarClass: CronosNavigatioBar.self, toolbarClass: nil)
    
    init(appDependencies: AppDependencies) {
        self.appDependencies = appDependencies
    }
    
    func pushLaunchViewControllerInWindow(window: UIWindow) {
        let launchViewModel = LaunchViewModel(navigationService: self)
        let launchViewController = LaunchViewController(viewModel: launchViewModel)
        rootNavigationController.pushViewController(launchViewController, animated: true)
        window.rootViewController = rootNavigationController
        window.makeKeyAndVisible()
    }

    func pushHomeViewController() {
        let homeViewModel = HomeViewModel(navigationService: self)
        let homeViewController = HomeViewController(viewModel: homeViewModel)
        rootNavigationController.pushViewController(homeViewController, animated: true)
    }

    func pushDetails(url: String) {
        let detailsViewModel = DetailsViewModel(url: url)
        let detailViewController = DetailsViewController(viewModel: detailsViewModel)
        rootNavigationController.pushViewController(detailViewController, animated: true)
    }

    // MARK: Moras raspoznati da li se radi o kvizu ili prici kasnije
    func pushMasterHomeViewController(mode: Mode) {
        let masterViewController = MasterHomeViewController(mode: mode, navigationService: self)
        rootNavigationController.pushViewController(masterViewController, animated: true)
    }

    func pushStory() {
        let story = StoryViewController()
        rootNavigationController.pushViewController(story, animated: true)
    }

    func pushMemory() {
        let memory = WebViewController()
        rootNavigationController.pushViewController(memory, animated: true)
    }

    func pushQuizFirst() {
        let quiz = QuizFirstViewController(navigationService: self)
        rootNavigationController.pushViewController(quiz, animated: true)
    }

    func pushSpeechRecognition() {
        let speech = SpeechRecognitionViewController(navigationService: self)
        rootNavigationController.pushViewController(speech, animated: true)
    }

    func pushFirstMaleFemalePicker() {
        let maleFemale = MaleFemaleViewController(navigationService: self)
        rootNavigationController.pushViewController(maleFemale, animated: true)
    }

    func pushVision() {
        let vision = GoogleVisionViewController(navigationService: self)
        rootNavigationController.pushViewController(vision, animated: true)
    }

    func pushCongratz() {
        let congratz = CongratzViewController()
        rootNavigationController.pushViewController(congratz, animated: true)
    }

    func pushZekoPeko() {
        let zekoPeko = ZekoPekoViewController(navigationService: self)
        rootNavigationController.pushViewController(zekoPeko, animated: true)
    }


}

