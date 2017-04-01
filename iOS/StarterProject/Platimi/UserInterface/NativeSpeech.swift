//
//  NativeSpeech.swift
//  Platimi
//
//  Created by Božidar on 01/04/2017.
//  Copyright © 2017 Božidar. All rights reserved.
//

import AVFoundation
import AudioToolbox
import RxSwift
import RxCocoa

enum SoundPlay: String {
    case intro = "djete_drago"
    case tutorialFirst = "trazi"
}

class NativeSpeech: NSObject, AVAudioPlayerDelegate {

    let soundFinished = PublishSubject<Bool>()

    private var bombSoundEffect: AVAudioPlayer?
    static let sharedInstance = NativeSpeech()

    func playSound(soundPlay: SoundPlay) {

        do {
            try AVAudioSession.sharedInstance().overrideOutputAudioPort(AVAudioSessionPortOverride.speaker)
        } catch _ {
        }

        let soundName = soundPlay.rawValue
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")!

        do {
            bombSoundEffect = try AVAudioPlayer(contentsOf: url)
            bombSoundEffect?.delegate = self
            guard let bombSound = bombSoundEffect else { return }

            bombSound.prepareToPlay()
            bombSound.play()
        } catch let error {
            print(error.localizedDescription)
        }

    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        soundFinished.onNext(true)
    }


}
