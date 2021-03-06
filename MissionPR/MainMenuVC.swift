//
//  MainMenuVC.swift
//  MissionPR
//
//  Created by Lane Faison on 5/31/17.
//  Copyright © 2017 Lane Faison. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation
import GooglePlaces

class MainMenuVC: UIViewController, CLLocationManagerDelegate, NSFetchedResultsControllerDelegate {
    
    var controller: NSFetchedResultsController<Gym_Location>!
    var controller2: NSFetchedResultsController<Gym_Visits>!
    var manager: CLLocationManager!
    var myLocation = CLLocationCoordinate2D()
    var gymLocation = CLLocationCoordinate2D()
    var okayToCheckIn = Bool()
    
    @IBOutlet weak var viewGoalsBtn: RoundedOutlineButton!
    @IBOutlet weak var gymCheckInBtn: RoundedOutlineButton!
    @IBOutlet weak var setGymBtn: RoundedOutlineButton!
    @IBOutlet weak var setGymLabel: UILabel!
    @IBOutlet weak var gymNameLabel: UILabel!
    @IBOutlet weak var gymStatusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gymCheckInBtn.isEnabled = false
        gymNameLabel.isHidden = true
        gymStatusLabel.isHidden = true
        okayToCheckIn = false
        
        DispatchQueue.main.async {
            self.manager = CLLocationManager()
            self.manager.delegate = self
            self.manager.desiredAccuracy = kCLLocationAccuracyBest
            self.manager.requestWhenInUseAuthorization()
            self.manager.startUpdatingLocation()
        }
        
        attemptFetch()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        self.myLocation = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
    }
    
    @IBAction func viewGoalsBtnPressed(_ sender: Any) {
        gymStatusLabel.isHidden = true
    }
    
    @IBAction func setGymBtnPressed(_ sender: UIButton) {
        gymStatusLabel.isHidden = true
        let autocompleteController = GMSAutocompleteViewController()
        let filter = GMSAutocompleteFilter()
        
        filter.type = .establishment
        autocompleteController.delegate = self
        autocompleteController.autocompleteFilter = filter
        present(autocompleteController, animated: true, completion: nil)
    }
    
    @IBAction func gymCheckInBtnPressed(_ sender: Any) {
        
        let gymCoordinates = CLLocation(latitude: gymLocation.latitude, longitude: gymLocation.longitude)
        let myCoordinates = CLLocation(latitude: myLocation.latitude, longitude: myLocation.longitude)
        let distance: CLLocationDistance = myCoordinates.distance(from: gymCoordinates)
        
        attemptVisitFetch()
        
        if distance < 100 && okayToCheckIn == true {
            gymStatusLabel.text = "You are checked in. Have a great workout!"
            gymStatusLabel.isHidden = false
            
            var newVisit: Gym_Visits!
            newVisit = Gym_Visits(context: context)
            
            let count = 1
            newVisit.count = Int16(count)
            
            let todaysDate = Date() as NSDate
            newVisit.date = todaysDate

            ad.saveContext()
        } else if distance < 100 && okayToCheckIn == false {
            gymStatusLabel.text = "You must wait 2 hours between check-ins."
            gymStatusLabel.isHidden = false
        } else if distance >= 100 {
            gymStatusLabel.text = "Our location data indicates that you are not currently located at your preset gym."
            gymStatusLabel.isHidden = false
        }
    }
    
    func attemptFetch() {
        let fetchRequest: NSFetchRequest<Gym_Location> = Gym_Location.fetchRequest()
        let nameSort = NSSortDescriptor(key: "name", ascending: false)
        fetchRequest.sortDescriptors = [nameSort]
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)

        controller.delegate = self
        self.controller = controller
        
        do {
            try controller.performFetch()
            let data = controller.fetchedObjects

            if (data?.count)! > 0 {
                gymCheckInBtn.isEnabled = true
                gymNameLabel.isHidden = false
                gymNameLabel.text = data![0].name!
                setGymLabel.text = "Gym set to:"
                
                gymLocation.latitude = data![0].latitude
                gymLocation.longitude = data![0].longitude
                
                gymCheckInBtn.backgroundColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1.0)
                
                setGymBtn.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0)
                setGymBtn.setTitle("✔️", for: .normal)
            }
        } catch {
            let error = error as NSError
            print("\(error)")
        }
    }
    
    func attemptVisitFetch() {
    
        let fetchRequest: NSFetchRequest<Gym_Visits> = Gym_Visits.fetchRequest()
        let dateSort = NSSortDescriptor(key: "date", ascending: false)
        fetchRequest.sortDescriptors = [dateSort]
        
        let controller2 = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        controller2.delegate = self
        self.controller2 = controller2
        
        do {
            try self.controller2.performFetch()
            let data = self.controller2.fetchedObjects
            if (data?.count)! > 0 {
                
                let lastCheckIn = (Date() as Date).timeIntervalSince(data![0].date as Date)
                
                if lastCheckIn < 7200 {
                    okayToCheckIn = false
                } else {
                    okayToCheckIn = true
                }
            } else {
                okayToCheckIn = true
            }
        } catch {
            let error = error as NSError
            print("\(error)")
        }
    }
    
    @IBAction func btnTouchDown(_ sender: UIButton) {
        
        if sender == viewGoalsBtn {
            viewGoalsBtn.backgroundColor = UIColor(red: 3/255, green: 169/255, blue: 244/255, alpha: 1.0)
        }
    }
    
    @IBAction func btn1TouchUpInside(_ sender: UIButton) {
        viewGoalsBtn.backgroundColor = UIColor(red: 169/255, green: 253/255, blue: 0, alpha: 1.0)
    }
}

extension MainMenuVC: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        let fetchRequest: NSFetchRequest<Gym_Location> = Gym_Location.fetchRequest()
        
        do {
            let array_gyms = try context.fetch(fetchRequest)
            if array_gyms.count > 0 {
                let gym = array_gyms[0]
                gym.setValue(place.name, forKey: "name")
                gym.setValue(place.coordinate.latitude, forKey: "latitude")
                gym.setValue(place.coordinate.longitude, forKey: "longitude")
                gymLocation = CLLocationCoordinate2D(latitude: gym.latitude, longitude: gym.longitude)
                
                do {
                    try context.save()
                } catch let error as NSError {
                    print("Could not save \(error), \(error.userInfo)")
                }  
            } else {
                let gym = Gym_Location(context: context)
                gym.name = place.name
                gym.latitude = place.coordinate.latitude
                gym.longitude = place.coordinate.longitude
                
                gymLocation = CLLocationCoordinate2D(latitude: gym.latitude, longitude: gym.longitude)
                ad.saveContext()
            }
        } catch {
            print("Error with request: \(error)")
        }
        
        dismiss(animated: true, completion: nil)
        attemptFetch()
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }    
}
