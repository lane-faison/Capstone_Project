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
    
    @IBOutlet weak var testLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
       updateDays()
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
        
        testLabel.text = "\(dayTrackerCount)/\(daysInCurrentMonth)"
    }

}
