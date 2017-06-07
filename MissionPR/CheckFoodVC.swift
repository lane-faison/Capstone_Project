//
//  CheckFoodVC.swift
//  MissionPR
//
//  Created by Lane Faison on 6/1/17.
//  Copyright © 2017 Lane Faison. All rights reserved.
//

import UIKit
import Photos
import CoreData
import SwiftyJSON

class CheckFoodVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var btnView: UIView!
    @IBOutlet weak var captureBtn: RoundedOutlineButton!
    @IBOutlet weak var labelResults: UITextView!
    @IBOutlet weak var resultsLabel: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    let imagePicker = UIImagePickerController()
    let session = URLSession.shared
    var googleURL: URL {
        return URL(string: "https://vision.googleapis.com/v1/images:annotate?key=\(GP_KEY)")!
    }
    var foodToCheck: Goal_Food!
//    let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: Selector(("rotateButton")), userInfo: nil, repeats: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: " ", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        imagePicker.delegate = self
        spinner.isHidden = true
        resultsLabel.isHidden = true
        
        if foodToCheck != nil {
            print(foodToCheck.name!)
        }
    }
    

    
    //$$$$$$$$$$$$$$$$$$$$$ IMAGE RECOGNITION FUNCTIONS $$$$$$$$$$$$$$$$$$$$$$
    
    @IBAction func findPhotoBtnPressed(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {

            imagePicker.allowsEditing = false
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.cameraCaptureMode = .photo
            imagePicker.modalPresentationStyle = .fullScreen
            present(imagePicker,animated: true,completion: nil)
        }
//        else {
//            imagePicker.allowsEditing = false
//            imagePicker.sourceType = .photoLibrary
//            present(imagePicker, animated: true, completion: nil)
//        }
    }
}

/// Image processing

extension CheckFoodVC {
    
    func analyzeResults(_ dataToParse: Data) {
        
        // Update UI on the main thread
        DispatchQueue.main.async(execute: {
            
            // Use SwiftyJSON to parse results
            let json = JSON(data: dataToParse)
            let errorObj: JSON = json["error"]
            
            self.spinner.stopAnimating()
            self.labelResults.isHidden = false
//            self.faceResults.isHidden = false
//            self.faceResults.text = ""
            
            // Check for errors
            if (errorObj.dictionaryValue != [:]) {
                self.labelResults.text = "Error code \(errorObj["code"]): \(errorObj["message"])"
            } else {
                // Parse the response
                print(json)
                let responses: JSON = json["responses"][0]
                
                // Get face annotations
                //                let faceAnnotations: JSON = responses["faceAnnotations"]
                //                if faceAnnotations != nil {
                //                    let emotions: Array<String> = ["joy", "sorrow", "surprise", "anger"]
                //
                //                    let numPeopleDetected:Int = faceAnnotations.count
                //
                //                    self.faceResults.text = "People detected: \(numPeopleDetected)\n\nEmotions detected:\n"
                //
                //                    var emotionTotals: [String: Double] = ["sorrow": 0, "joy": 0, "surprise": 0, "anger": 0]
                //                    var emotionLikelihoods: [String: Double] = ["VERY_LIKELY": 0.9, "LIKELY": 0.75, "POSSIBLE": 0.5, "UNLIKELY":0.25, "VERY_UNLIKELY": 0.0]
                //
                //                    for index in 0..<numPeopleDetected {
                //                        let personData:JSON = faceAnnotations[index]
                //
                //                        // Sum all the detected emotions
                //                        for emotion in emotions {
                //                            let lookup = emotion + "Likelihood"
                //                            let result:String = personData[lookup].stringValue
                //                            emotionTotals[emotion]! += emotionLikelihoods[result]!
                //                        }
                //                    }
                //                    // Get emotion likelihood as a % and display in UI
                //                    for (emotion, total) in emotionTotals {
                //                        let likelihood:Double = total / Double(numPeopleDetected)
                //                        let percent: Int = Int(round(likelihood * 100))
                //                        self.faceResults.text! += "\(emotion): \(percent)%\n"
                //                    }
                //                } else {
                //                    self.faceResults.text = "No faces found"
                //                }
                
                // Get label annotations
                let labelAnnotations: JSON = responses["labelAnnotations"]
                let numLabels: Int = labelAnnotations.count
                var labels: Array<String> = []
                if numLabels > 0 {
                    var labelResultsText:String = "Labels found: "
                    for index in 0..<numLabels {
                        let label = labelAnnotations[index]["description"].stringValue
                        labels.append(label)
                    }
                    for label in labels {
                        
                        
                        labelResultsText += "\(label), "
                        
                        if label == self.foodToCheck.name {
                            print("$$$$$ We have detected a \(self.foodToCheck.name!)!")
                            var foodFound: Food_Log!
                            foodFound = Food_Log(context: context)
                            foodFound.name = label
                            foodFound.date = Date() as NSDate
                            ad.saveContext()
                            self.spinner.isHidden = true
                            let nameCapitalized = label.capitalized
                            self.resultsLabel.text = "Success! \(nameCapitalized) detected!"
                            self.resultsLabel.isHidden = false
                            return
                        } else {

                            print("$$$$$ We did not find a match")
                        }
                    }
//                    self.labelResults.text = labelResultsText
                      self.spinner.isHidden = true
                      self.resultsLabel.text = "Not a \(self.foodToCheck.name!)"
                      self.resultsLabel.isHidden = false
                } else {
                    self.labelResults.text = "No labels found"
                }
            }
        })
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            //            imageView.contentMode = .scaleAspectFit
            //            imageView.isHidden = true // You could optionally display the image here by setting imageView.image = pickedImage
            spinner.isHidden = false
            spinner.startAnimating()
//            let btnTransform = CGAffineTransform(rotationAngle: CGFloat(20.0*Double.pi))
//            UIView.animate(withDuration: 5.0, animations: ({
//                self.captureBtn.transform = btnTransform
//            }))
//            faceResults.isHidden = true
            labelResults.isHidden = true
            
            // Base64 encode the image and create the request
            let binaryImageData = base64EncodeImage(pickedImage)
            createRequest(with: binaryImageData)
        }
        
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


/// Networking

extension CheckFoodVC {
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

