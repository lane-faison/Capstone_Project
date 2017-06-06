//
//  FoodGoalCell.swift
//  MissionPR
//
//  Created by Lane Faison on 6/5/17.
//  Copyright © 2017 Lane Faison. All rights reserved.
//

import UIKit
import CoreData

class FoodGoalCell: UITableViewCell, NSFetchedResultsControllerDelegate {

    var controller: NSFetchedResultsController<Food_Log>!
    var totalFruit = Int()
    var totalVegetables = Int()
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var current: UILabel!
    @IBOutlet weak var goal: UILabel!
    
    func configureCell(goalFood: Goal_Food) {
        view.layer.cornerRadius = 5
        
        goal.text = "31"

//        attemptFetch()
        
        if goalFood.name == "fruit" {
            name.text = "Fruit"
            attemptFetch()
            current.text = "\(totalFruit)"
        }
        if goalFood.name == "vegetable" {
            name.text = "Vegetables"
            attemptFetch()
            current.text = "\(totalVegetables)"
        }
        
    }
    
    func attemptFetch() {
        
        let fetchRequest: NSFetchRequest<Food_Log> = Food_Log.fetchRequest()
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
                for log in data! {
                    print("$$$$$$$$$$$$$$")
                    print(log.date!) // type = NSDate
                    let component1 = NSCalendar.current.dateComponents([.month,.year,.day], from: (Date() as NSDate) as Date)
                    let component2 = NSCalendar.current.dateComponents([.month,.year], from: log.date! as Date)
                    
                    if component1.month == component2.month && component1.year == component2.year {
                        print("SAME MONTH & YEAR")
                        if log.name == "fruit" {
                            totalFruit += 1
                            print("FOUND FRUIT")
                        }
                        if log.name == "vegetable" {
                            totalVegetables += 1
                            print("FOUND VEGETABLE")
                        }
                    }
                }
            }
        } catch {
            let error = error as NSError
            print("\(error)")
        }
    }
}
