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

    var controller: NSFetchedResultsController<Gym_Visits>!
    var dayTrackerCount = Int()
    var daysInCurrentMonth = Int()
    var nameOfMonth = String()
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        nameOfMonth = dateFormatter.string(from: Date() as Date)
        
        let transform = CGAffineTransform(rotationAngle: CGFloat(3*Double.pi/2)).scaledBy(x: 1.0, y: 20.0)

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
            print("###### FETCH ######")
            let data = self.controller.fetchedObjects
            if (data?.count)! > 0 {
               print((data?.count)!)
                for day in data! {
                    print("$$$$$$$$$$$$$$")
                    print(day.date) // type = NSDate
                    let component1 = NSCalendar.current.dateComponents([.month,.year], from: (Date() as NSDate) as Date)
                    let component2 = NSCalendar.current.dateComponents([.month,.year], from: day.date as Date)

                    if component1.month == component2.month && component1.year == component2.year {
                        print("SAME MONTH & YEAR")
                        dayTrackerCount += 1
                        print(dayTrackerCount)
                    }
                }
            }
        } catch {
            let error = error as NSError
            print("\(error)")
        }
    }

    func getCurrentDaysInMonth() {
        let currentDateInfo = NSCalendar.current.dateComponents([.month,.year], from: (Date() as NSDate) as Date)

        let dateComponents = DateComponents(year: currentDateInfo.year, month: currentDateInfo.month)
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!
        
        let range = calendar.range(of: .day, in: .month, for: date)!
        let numOfDays = range.count
        print(numOfDays)
    }
    
    func updateDays() {
        attemptFetch()
        
        let currentDateInfo = NSCalendar.current.dateComponents([.month,.year], from: (Date() as NSDate) as Date)
        
        let dateComponents = DateComponents(year: currentDateInfo.year, month: currentDateInfo.month)
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!
        
        let range = calendar.range(of: .day, in: .month, for: date)!
        daysInCurrentMonth = range.count
        
        label1.text = "\(daysInCurrentMonth) days in \(nameOfMonth)"
        label2.text = "\(dayTrackerCount) visits to a gym so far!"
    }
    
    func configureProgress() {
        
        let progress = Float(dayTrackerCount)/Float(daysInCurrentMonth)
        
        progressBar.setProgress(Float(dayTrackerCount)/Float(daysInCurrentMonth), animated: true)
        
        if progress <= 1.00 {
            progressBar.progressTintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1.0)
        }
        if progress <= 2/3 {
            progressBar.progressTintColor = UIColor(red: 255/255, green: 149/255, blue: 0/255, alpha: 1.0)
        }
        if progress <= 1/3 {
            progressBar.progressTintColor = UIColor(red: 244/255, green: 67/255, blue: 54/255, alpha: 1.0)
        }
    }

}
