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
    var daysInMonth = Int()
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var current: UILabel!
    @IBOutlet weak var goal: UILabel!
    
    func configureCell(goalFood: Goal_Food) {
        totalFruit = 0
        totalVegetables = 0
        
        attemptFetch()
        
        view.layer.cornerRadius = 5
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        let nameOfMonth = dateFormatter.string(from: Date() as Date)
        
        let interval = Calendar.current.dateInterval(of: .month, for: Date() as Date)!
        daysInMonth = Calendar.current.dateComponents([.day], from: interval.start, to: interval.end).day!
        goal.text = "\(daysInMonth)"
        
        if goalFood.name == "fruit" {
            name.text = "🍎 Fruit in \(nameOfMonth)"
            current.text = "\(totalFruit)"
        }
        if goalFood.name == "vegetable" {
            name.text = "🥕 Vegetables in \(nameOfMonth)"
            current.text = "\(totalVegetables)"
        }
    }
    
    func configureProgress(goalFood: Goal_Food) {
        
        var foodSoFar = Int()
        
        if goalFood.name == "fruit" {
            foodSoFar = totalFruit
        }
        if goalFood.name == "vegetable" {
            foodSoFar = totalVegetables
        }
        
        let transform = CGAffineTransform(scaleX: 1.0, y: 10.0)
        self.progressView.transform = transform
        
        let progress = Float(foodSoFar)/Float(daysInMonth)
        
        var progressRatio: Float!
        
        if progress >= 1.00 {
            progressRatio = 1.00
            self.view.layer.borderWidth = 4
            self.view.layer.borderColor = UIColor(red: 114/255, green: 201/255, blue: 0/255, alpha: 1.0).cgColor
        } else {
            self.view.layer.borderWidth = 0
            progressRatio = progress
        }
        
        progressView.setProgress(progressRatio, animated: true)
        
        if progressRatio > 0.85 {
            progressView.progressTintColor = UIColor(red: 169/255, green: 253/255, blue: 0/255, alpha: 1.0)
        }
        if progressRatio <= 0.85 {
            progressView.progressTintColor = UIColor(red: 3/255, green: 169/255, blue: 244/255, alpha: 1.0)
        }
        if progressRatio <= 0.70 {
            progressView.progressTintColor = UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 1.0)
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

            let data = self.controller.fetchedObjects
            
            if (data?.count)! > 0 {
                for log in data! {
                    let component1 = NSCalendar.current.dateComponents([.month,.year,.day], from: (Date() as NSDate) as Date)
                    let component2 = NSCalendar.current.dateComponents([.month,.year], from: log.date! as Date)
                    
                    if component1.month == component2.month && component1.year == component2.year {
                        if log.name == "fruit" {
                            totalFruit += 1
                        }
                        if log.name == "vegetable" {
                            totalVegetables += 1
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
