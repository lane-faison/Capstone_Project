//
//  MainMenuVC.swift
//  MissionPR
//
//  Created by Lane Faison on 5/31/17.
//  Copyright © 2017 Lane Faison. All rights reserved.
//

import UIKit
import GooglePlaces
import CoreData

class MainMenuVC: UIViewController, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var viewGoalsBtn: RoundedOutlineButton!
    @IBOutlet weak var addGoalsBtn: RoundedOutlineButton!
    @IBOutlet weak var gymCheckInBtn: RoundedOutlineButton!
    @IBOutlet weak var setGymBtn: RoundedOutlineButton!
    @IBOutlet weak var setGymLabel: UILabel!
    @IBOutlet weak var gymNameLabel: UILabel!
    
    var controller: NSFetchedResultsController<Gym_Location>!
    var gymCoordinates = CLLocationCoordinate2D()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gymCheckInBtn.isEnabled = false
        gymNameLabel.isHidden = true
        
        attemptFetch()
    }
    
    @IBAction func setGymBtnPressed(_ sender: UIButton) {
        let autocompleteController = GMSAutocompleteViewController()
        let filter = GMSAutocompleteFilter()
        
        // Restrict results to establishments in the United States
        filter.type = .establishment
        filter.country = "us"
        autocompleteController.delegate = self
        autocompleteController.autocompleteFilter = filter
        present(autocompleteController, animated: true, completion: nil)
    }
    
    @IBAction func gymCheckInBtnPressed(_ sender: Any) {
        
        print("TAPPED")
        print(gymCoordinates)
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
                
                setGymBtn.backgroundColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1.0)
                setGymBtn.setTitle("!", for: .normal)
            }
        } catch {
            let error = error as NSError
            print("\(error)")
        }
    }
}

extension MainMenuVC: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place name: \(place.name)")
        print("Place address: \(String(describing: place.formattedAddress))")
        print("Place attributions: \(String(describing: place.attributions))")
        print("Place coordinates: \(place.coordinate)")
        
        let gym = Gym_Location(context: context)
        gym.name = place.name
        gym.latitude = place.coordinate.latitude
        gym.longitude = place.coordinate.longitude
        gymCoordinates = CLLocationCoordinate2D(latitude: gym.latitude, longitude: gym.longitude)
        ad.saveContext()
        print("Gym name: \(gym.name!)")
        print("Gym lat: \(gym.latitude)")
        print("Gym lng: \(gym.longitude)")
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
