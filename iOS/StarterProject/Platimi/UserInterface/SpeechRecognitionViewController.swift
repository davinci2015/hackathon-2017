//
//  SpeechRecognitionViewController.swift
//  Platimi
//
//  Created by Božidar on 01/04/2017.
//  Copyright © 2017 Božidar. All rights reserved.
//

import UIKit
import Speech
import RxSwift

class SpeechRecognitionViewController: UIViewController, SFSpeechRecognizerDelegate {


    let audioEngine = AVAudioEngine()
    let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer()
    let request = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask: SFSpeechRecognitionTask?
    private var disposeBag = DisposeBag()

    private let animationDuration: TimeInterval = 1.0

    fileprivate var navigationService: NavigationService?

    convenience init(navigationService: NavigationService) {
        self.init()
        self.navigationService = navigationService
    }

    @IBOutlet weak var detectedTextLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        startWithNativeSpeech()
    }

    // Startam sound
    func startWithNativeSpeech() {
        let nativeSpeech = NativeSpeech.sharedInstance
        nativeSpeech.playSound(soundPlay: .intro)

        nativeSpeech.soundFinished.filter{$0}.subscribe(onNext: { [weak self] finished in
//            self?.recordAndRecognizeSpeech()
        }).addDisposableTo(disposeBag)

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

//    func checkForColorSaid(resultString: String) {
//        switch resultString {
//        case "red":
//            colorView.backgroundColor = UIColor.red
//        case "orange":
//            colorView.backgroundColor = UIColor.orange
//        case "yellow":
//            colorView.backgroundColor = UIColor.yellow
//        case "green":
//            colorView.backgroundColor = UIColor.green
//        case "blue":
//            colorView.backgroundColor = UIColor.blue
//        case "purple":
//            colorView.backgroundColor = UIColor.purple
//        case "black":
//            colorView.backgroundColor = UIColor.black
//        case "white":
//            colorView.backgroundColor = UIColor.white
//        case "gray":
//            colorView.backgroundColor = UIColor.gray
//        default: break
//        }
//    }

    func checkCorrectAnswer(result: SFSpeechRecognitionResult?, error: Error?) {
        if let result = result {
            let bestString = result.bestTranscription.formattedString
            self.detectedTextLabel.text = "Izrekli ste: \(bestString)"
            
            /////// ODAVDJE IDE UI
            //                var lastString: String = ""
            //                for segment in result.bestTranscription.segments {
            //                    let indexTo = bestString.index(bestString.startIndex, offsetBy: segment.substringRange.location)
            //                    lastString = bestString.substring(from: indexTo)
            //                }
            //                self.checkForColorSaid(resultString: lastString.lowercased())

            ///////




            self.cancelRecording()

            if bestString == "Kontejner" ||  bestString == "Kontenjer" || bestString == "Kanta" {

                Timer.scheduledTimer(timeInterval: self.animationDuration, target: self, selector: #selector(self.nextScreen), userInfo: nil, repeats: false)
            }



        } else if let error = error {
            self.cancelRecording()
//            presentAlert()
            print(error)
        }
    }

    func presentAlert() {
        let alert = UIAlertController(title: "Network error", message: "No internet connection", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
//        nextScreen()
    }

    func nextScreen() {
        navigationService?.pushVision()
    }

    func cancelRecording() {
        audioEngine.stop()
        if let node = audioEngine.inputNode {
            node.removeTap(onBus: 0)
        }
        recognitionTask?.cancel()
    }


    @IBAction func startButtonTapped(_ sender: Any) {
        recordAndRecognizeSpeech()
    }

}
