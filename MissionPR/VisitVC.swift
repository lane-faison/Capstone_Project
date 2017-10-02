//
//  VisitVC.swift
//  MissionPR
//
//  Created by Lane Faison on 6/2/17.
//  Copyright © 2017 Lane Faison. All rights reserved.
//

import UIKit
import CoreData

class VisitVC: UIViewController, NSFetchedResultsControllerDelegate {

    private var controller: NSFetchedResultsController<Gym_Visits>!
    private var dayTrackerCount = Int()
    private var daysInCurrentMonth = Int()
    private var nameOfMonth = String()
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    let dateFormatter = DateFormatter()
    
    let transform = CGAffineTransform(rotationAngle: CGFloat(3*Double.pi/2)).scaledBy(x: 1.0, y: 20.0)

    override func viewDidLoad() {
        super.viewDidLoad()

        dateFormatter.dateFormat = "MMMM"
        nameOfMonth = dateFormatter.string(from: Date() as Date)
        
        progressBar.transform = transform
        
        updateDays()
        configureProgress()
    }

    func attemptFetch() {
        
        let fetchRequest: NSFetchRequest<Gym_Visits> = Gym_Visits.fetchRequest()
        let dateSort = NSSortDescriptor(key: "date", ascending: true)
        fetchRequest.sortDescriptors = [dateSort]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        controller.delegate = self
        self.controller = controller
        
        do {
            try self.controller.performFetch()
            guard let data = self.controller.fetchedObjects else { return }
            if data.count > 0 {
                
                for day in data {

                    let component1 = NSCalendar.current.dateComponents([.month,.year], from: (Date() as NSDate) as Date)
                    let component2 = NSCalendar.current.dateComponents([.month,.year], from: day.date as Date)

                    if component1.month == component2.month && component1.year == component2.year {
                        dayTrackerCount += 1
                    }
                }
            }
        } catch let error {
            print("\(error)")
        }
    }
    
    func updateDays() {
        attemptFetch()
        
        let currentDateInfo = NSCalendar.current.dateComponents([.month,.year], from: (Date() as NSDate) as Date)
        
        let dateComponents = DateComponents(year: currentDateInfo.year, month: currentDateInfo.month)
        let calendar = Calendar.current
        guard let date = calendar.date(from: dateComponents) else { return }
        guard let range = calendar.range(of: .day, in: .month, for: date) else { return }
        daysInCurrentMonth = range.count
        
        label1.text = "\(daysInCurrentMonth) days in \(nameOfMonth)"
        label2.text = "\(dayTrackerCount) visits to a gym so far!"
    }
    
    func configureProgress() {
        
        let progressRatio = Float(dayTrackerCount)/Float(daysInCurrentMonth)
        
        progressBar.setProgress(Float(dayTrackerCount)/Float(daysInCurrentMonth), animated: true)
        
        if progressRatio > 0.85 {
            progressBar.progressTintColor = UIColor(red: 169/255, green: 253/255, blue: 0/255, alpha: 1.0)
        }
        if progressRatio <= 0.85 {
            progressBar.progressTintColor = UIColor(red: 3/255, green: 169/255, blue: 244/255, alpha: 1.0)
        }
        if progressRatio <= 0.70 {
            progressBar.progressTintColor = UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 1.0)
        }
    }
}
