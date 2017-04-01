//
//  GoogleVisionViewController.swift
//  Platimi
//
//  Created by Božidar on 01/04/2017.
//  Copyright © 2017 Božidar. All rights reserved.
//

import UIKit
import RxSwift
import SwiftyJSON
import Gifu

class GoogleVisionViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate  {


    private var myArray = ["bottle", "paper", "plastic"]

    @IBOutlet weak var labelResults: UILabel!
    @IBOutlet weak var imageTake: UIImageView!
    var imagePicker: UIImagePickerController!
    private let disposeBag = DisposeBag()
    let session = URLSession.shared
    fileprivate var pased = false
    let imageView = GIFImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))



    var googleAPIKey = "AIzaSyAyah2JDWqkBpI4ia7gK_Gq1kjz1BMarmI"
    var googleURL: URL {
        return URL(string: "https://vision.googleapis.com/v1/images:annotate?key=\(googleAPIKey)")!
    }

    fileprivate var navigationService: NavigationService?

    convenience init(navigationService: NavigationService) {
        self.init()
        self.navigationService = navigationService
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        startWithNativeSpeech()

        self.imageView.frame = view.frame
//        imageView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width / 2, height: self.view.frame.height / 2)
        imageView.animate(withGIFNamed: "zec")
        view.addSubview(imageView)

        setStyle()

    }

    func setStyle() {
        imageTake.layer.cornerRadius = 10
        imageTake.layer.shadowColor = UIColor.black.withAlphaComponent(0.18).cgColor
        imageTake.layer.shadowOffset = CGSize(width: 0, height: 8.0)
        imageTake.layer.shadowRadius = 8.0
        imageTake.layer.shadowOpacity = 1.0
        imageTake.layer.masksToBounds = false
        imageTake.layer.rasterizationScale = UIScreen.main.scale
        imageTake.layer.shouldRasterize = true

        imageTake.alpha = 0.8

        setNavigationBarStyle()
    }

    func setNavigationBarStyle() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }

    // Startam sound
    func startWithNativeSpeech() {
        let nativeSpeech = NativeSpeech.sharedInstance
        nativeSpeech.playSound(soundPlay: .tutorialFirst)

        nativeSpeech.soundFinished.filter{$0}.subscribe(onNext: { [weak self] finished in
            self?.takePhoto()
        }).addDisposableTo(disposeBag)

    }


    func takePhoto() {
        imageView.stopAnimatingGIF()
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            var imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }

    @IBAction func plusTapped(_ sender: UIButton) {
        navigationService?.pushCongratz()
    }
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
//        imageTake.image = chosenImage
//        dismiss(animated: true, completion: nil)
//    }
}

extension GoogleVisionViewController {

    func analyzeResults(_ dataToParse: Data) {

        // Update UI on the main thread
        DispatchQueue.main.async(execute: {


            // Use SwiftyJSON to parse results
            let json = JSON(data: dataToParse)
            let errorObj: JSON = json["error"]

            self.labelResults.isHidden = false

            // Check for errors
            if (errorObj.dictionaryValue != [:]) {
                self.labelResults.text = "Error code \(errorObj["code"]): \(errorObj["message"])"
            } else {
                // Parse the response
                print(json)
                let responses: JSON = json["responses"][0]

                // Get face annotations
                let faceAnnotations: JSON = responses["faceAnnotations"]
                if faceAnnotations != nil {
                    let emotions: Array<String> = ["joy", "sorrow", "surprise", "anger"]

                    let numPeopleDetected:Int = faceAnnotations.count


                    var emotionTotals: [String: Double] = ["sorrow": 0, "joy": 0, "surprise": 0, "anger": 0]
                    var emotionLikelihoods: [String: Double] = ["VERY_LIKELY": 0.9, "LIKELY": 0.75, "POSSIBLE": 0.5, "UNLIKELY":0.25, "VERY_UNLIKELY": 0.0]

                    for index in 0..<numPeopleDetected {
                        let personData:JSON = faceAnnotations[index]

                        // Sum all the detected emotions
                        for emotion in emotions {
                            let lookup = emotion + "Likelihood"
                            let result:String = personData[lookup].stringValue
                            emotionTotals[emotion]! += emotionLikelihoods[result]!
                        }
                    }
                    // Get emotion likelihood as a % and display in UI

                }

                // Get label annotations
                let labelAnnotations: JSON = responses["labelAnnotations"]
                let numLabels: Int = labelAnnotations.count
                var labels: Array<String> = []
                if numLabels > 0 {
                    var labelResultsText:String = ""
                    for index in 0..<numLabels {
                        let label = labelAnnotations[index]["description"].stringValue
                        labels.append(label)
                    }
                    for label in labels {
                        // if it's not the last item add a comma
                        if labels[labels.count - 1] != label {
                            labelResultsText += "\(label), "
                        } else {
                            labelResultsText += "\(label)"
                        }
                    }
                    self.labelResults.text = labelResultsText
                } else {
                    self.labelResults.text = "No labels found"
                }
            }
        })
    }



    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageTake.contentMode = .scaleAspectFit
            imageTake.image = pickedImage
//            spinner.startAnimating()
            labelResults.isHidden = true

            // Base64 encode the image and create the request
            let binaryImageData = base64EncodeImage(pickedImage)
            createRequest(with: binaryImageData)
        }

        imageView.removeFromSuperview()

        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    func resizeImage(_ imageSize: CGSize, image: UIImage) -> Data {
        UIGraphicsBeginImageContext(imageSize)
        image.draw(in: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        let resizedImage = UIImagePNGRepresentation(newImage!)
        UIGraphicsEndImageContext()
        return resizedImage!
    }
}

extension GoogleVisionViewController {
    func base64EncodeImage(_ image: UIImage) -> String {
        var imagedata = UIImagePNGRepresentation(image)

        // Resize the image if it exceeds the 2MB API limit
        if (imagedata?.count > 2097152) {
            let oldSize: CGSize = image.size
            let newSize: CGSize = CGSize(width: 800, height: oldSize.height / oldSize.width * 800)
            imagedata = resizeImage(newSize, image: image)
        }

        return imagedata!.base64EncodedString(options: .endLineWithCarriageReturn)
    }

    func createRequest(with imageBase64: String) {
        // Create our request URL

        var request = URLRequest(url: googleURL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(Bundle.main.bundleIdentifier ?? "", forHTTPHeaderField: "X-Ios-Bundle-Identifier")

        // Build our API request
        let jsonRequest = [
            "requests": [
                "image": [
                    "content": imageBase64
                ],
                "features": [
                    [
                        "type": "LABEL_DETECTION",
                        "maxResults": 10
                    ],
                    [
                        "type": "FACE_DETECTION",
                        "maxResults": 10
                    ]
                ]
            ]
        ]
        let jsonObject = JSON(jsonDictionary: jsonRequest)

        // Serialize the JSON
        guard let data = try? jsonObject.rawData() else {
            return
        }

        request.httpBody = data

        // Run the request on a background thread
        DispatchQueue.global().async { self.runRequestOnBackgroundThread(request) }
    }

    func runRequestOnBackgroundThread(_ request: URLRequest) {
        // run the request

        let task: URLSessionDataTask = session.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }

            self.analyzeResults(data)
        }

        task.resume()
    }
}


// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    default:
        return rhs < lhs
    }
}
