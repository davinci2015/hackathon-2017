//
//  ZekoPekoViewController.swift
//  Platimi
//
//  Created by Božidar on 01/04/2017.
//  Copyright © 2017 Božidar. All rights reserved.
//

import UIKit
import Speech
import RxSwift
import Gifu

class ZekoPekoViewController: UIViewController {

    fileprivate var navigationService: NavigationService?

    @IBOutlet weak var myName: UILabel!
    @IBOutlet weak var zekoIntro: UILabel!
    @IBOutlet weak var zekoResponse: UILabel!
    fileprivate var name: String?

    private let disposeBag = DisposeBag()

    let audioEngine = AVAudioEngine()
    let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer()
    let request = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask: SFSpeechRecognitionTask?


    convenience init(navigationService: NavigationService) {
        self.init()
        self.navigationService = navigationService
    }
    
    let imageView = GIFImageView(frame: CGRect(x: 0, y: 140, width: 250, height: 250))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.animate(withGIFNamed: "zec")
        view.addSubview(imageView)
        animate()

        zekoIntro.animate(newText: zekoIntro.text ?? "May the source be with you", characterDelay: 0.1)

        recordAndRecognizeSpeech()



//        imageView.frame = CGRect(x: 50, y: self.view.frame.height/2 - 100, width: 100, height: 100)
    }

    func recordAndRecognizeSpeech() {
        guard let node = audioEngine.inputNode else { return }
        let recordingFormat = node.outputFormat(forBus: 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            self.request.append(buffer)
        }

        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            self.cancelRecording()
            return print(error)
        }


        guard let myRecognizer = SFSpeechRecognizer() else {
            return
        }
        if !myRecognizer.isAvailable {
            return
        }



        recognitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: { result, error in
            self.checkCorrectAnswer(result: result, error: error)
        })
        
    }

    func checkCorrectAnswer(result: SFSpeechRecognitionResult?, error: Error?) {
        if let result = result {
            let bestString = result.bestTranscription.formattedString
            self.myName.animate(newText: "Ja: \(bestString)", characterDelay: 0.1)
            name = bestString

            Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.zekoRes), userInfo: nil, repeats: false)
//             self.detectedTextLabel.text = "Izrekli ste: \(bestString)"

            /////// ODAVDJE IDE UI
            //                var lastString: String = ""
            //                for segment in result.bestTranscription.segments {
            //                    let indexTo = bestString.index(bestString.startIndex, offsetBy: segment.substringRange.location)
            //                    lastString = bestString.substring(from: indexTo)
            //                }
            //                self.checkForColorSaid(resultString: lastString.lowercased())

            ///////




            self.cancelRecording()

           



        } else if let error = error {
            self.cancelRecording()
            //            presentAlert()
            print(error)
        }
    }

    func zekoRes() {
        if let name = name {
            zekoResponse.animate(newText: "Zeko: Bok \(name)", characterDelay: 0.1)
        }

        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.nextScreen), userInfo: nil, repeats: false)

    }

    func nextScreen() {
        navigationService?.pushFirstMaleFemalePicker()
    }

    func cancelRecording() {
        audioEngine.stop()
        if let node = audioEngine.inputNode {
            node.removeTap(onBus: 0)
        }
        recognitionTask?.cancel()
    }

    func animate() {
        UIView.animate(withDuration: 20.0, animations: {
            self.imageView.frame.origin.x += 300
        }) { _ in
            print("zec je gotov")
        }
    }
}

extension UILabel {

    func animate(newText: String, characterDelay: TimeInterval) {

        DispatchQueue.main.async {

            self.text = ""

            for (index, character) in newText.characters.enumerated() {
                DispatchQueue.main.asyncAfter(deadline: .now() + characterDelay * Double(index)) {
                    self.text?.append(character)
                }
            }
        }
    }
    
}
