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
    
    @IBOutlet weak var captureBtn: RoundedOutlineButton!
    @IBOutlet weak var resultsLabel: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var noCameraMessage: UILabel!
    @IBOutlet weak var deleteBtn: UIBarButtonItem!
    
    let imagePicker = UIImagePickerController()
    let session = URLSession.shared
    var googleURL: URL {
        return URL(string: "https://vision.googleapis.com/v1/images:annotate?key=\(GP_KEY)")!
    }
    var foodToCheck: Goal_Food!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: " ", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        }
        
        imagePicker.delegate = self
        spinner.isHidden = true
        resultsLabel.isHidden = true
        noCameraMessage.isHidden = true
    }
    
    @IBAction func findPhotoBtnPressed(_ sender: UIButton) {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            captureBtn.backgroundColor = UIColor(red: 169/255, green: 253/255, blue: 0/255, alpha: 1.0)
            noCameraMessage.isHidden = true
            imagePicker.allowsEditing = false
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.cameraCaptureMode = .photo
            imagePicker.modalPresentationStyle = .fullScreen
            present(imagePicker,animated: true,completion: nil)
        } else {
            //
        }
    }
    
    @IBAction func btnTouchDown(_ sender: UIButton) {
        
        if sender == captureBtn {
            captureBtn.backgroundColor = UIColor(red: 3/255, green: 169/255, blue: 244/255, alpha: 1.0)
        }
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            noCameraMessage.isHidden = true
            imagePicker.allowsEditing = false
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.cameraCaptureMode = .photo
            imagePicker.modalPresentationStyle = .fullScreen
            present(imagePicker,animated: true,completion: nil)
        } else {
         //
        }
    }
    
    @IBAction func deletePressed(_ sender: Any) {
        if foodToCheck != nil {
            context.delete(foodToCheck!)
            ad.saveContext()
        }
        navigationController?.popViewController(animated: true)
    }
}

extension CheckFoodVC {
    
    func analyzeResults(_ dataToParse: Data) {
        
        // Update UI on the main thread
        DispatchQueue.main.async(execute: {
            
            // Use SwiftyJSON to parse results
            let json = try JSON(data: dataToParse)
            let errorObj: JSON = json["error"]
            
            self.spinner.stopAnimating()
            
            // Check for errors
            if (errorObj.dictionaryValue != [:]) {
                print("Error code \(errorObj["code"]): \(errorObj["message"])")
            } else {
                // Parse the response
                print(json)
                let responses: JSON = json["responses"][0]
                
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
                        print(labelResultsText)
                        
                        if label == self.foodToCheck.name {
                            var foodFound: Food_Log!
                            foodFound = Food_Log(context: context)
                            foodFound.name = label
                            foodFound.date = Date() as NSDate
                            ad.saveContext()
                            self.spinner.isHidden = true
                            let nameCapitalized = label.capitalized
                            self.resultsLabel.text = "\(nameCapitalized)!"
                            self.resultsLabel.isHidden = false
                            return
                        } else {
                            print("We did not find a match")
                        }
                    }
                    self.spinner.isHidden = true
                    self.resultsLabel.text = "Not \(self.foodToCheck.name!)"
                    self.resultsLabel.isHidden = false
                } else {
                    print("No labels found.")
                }
            }
            } as! @convention(block) () -> Void)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
// Local variable inserted by Swift 4.2 migrator.
let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

        if let pickedImage = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage {
            
            spinner.isHidden = false
            spinner.startAnimating()
            
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
        let resizedImage = newImage!.pngData()
        UIGraphicsEndImageContext()
        return resizedImage!
    }
}

/// Networking
extension CheckFoodVC {
    func base64EncodeImage(_ image: UIImage) -> String {
        var imagedata = image.pngData()
        
        // Resize the image if it exceeds the 2MB API limit
        if (imagedata?.count > 2097152) {
            let oldSize: CGSize = image.size
            let newSize: CGSize = CGSize(width: 800, height: oldSize.height / oldSize.width * 800)
            imagedata = resizeImage(newSize, image: image)
        }
        
        return imagedata!.base64EncodedString(options: .endLineWithCarriageReturn)
    }
    
    func createRequest(with imageBase64: String) {
//        // Create our request URL
//        
//        var request = URLRequest(url: googleURL)
//        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue(Bundle.main.bundleIdentifier ?? "", forHTTPHeaderField: "X-Ios-Bundle-Identifier")
//        
//        // Build our API request
//        let jsonRequest = [
//            "requests": [
//                "image": [
//                    "content": imageBase64
//                ],
//                "features": [
//                    [
//                        "type": "LABEL_DETECTION",
//                        "maxResults": 10
//                    ],
//                    [
//                        "type": "FACE_DETECTION",
//                        "maxResults": 10
//                    ]
//                ]
//            ]
//        ]
//        let jsonObject = JSON(jsonDictionary: jsonRequest)
//        
//        // Serialize the JSON
//        guard let data = try? jsonObject.rawData() else {
//            return
//        }
//        
//        request.httpBody = data
//        
//        // Run the request on a background thread
//        DispatchQueue.global().async { self.runRequestOnBackgroundThread(request) }
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

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}
