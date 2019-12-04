//
//  LiftsVC.swift
//  MissionPR
//
//  Created by Lane Faison on 5/31/17.
//  Copyright © 2017 Lane Faison. All rights reserved.
//

import UIKit
import CoreData

class LiftsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var directionsLabel: UILabel!
    
    var controller: NSFetchedResultsController<Goal_Lift>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: " ", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        }
        
        tableView.delegate = self
        tableView.dataSource = self

//        generateTestData()
        attemptFetch()
    }
    
    func configureCell(cell: LiftGoalCell, indexPath: NSIndexPath) {
        let goal = controller.object(at: indexPath as IndexPath)
        cell.configureCell(goalLift: goal)
        cell.configureProgress(goalLift: goal)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LiftGoalCell", for: indexPath) as! LiftGoalCell
        configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let objs = controller.fetchedObjects , objs.count > 0 {
            let goal = objs[indexPath.row]
            performSegue(withIdentifier: "editGoal", sender: goal)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editGoal" {
            if let destination = segue.destination as? AddLiftVC {
                if let goal = sender as? Goal_Lift {
                    destination.goalToEdit = goal
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = controller.sections {
            let sectionInfo = sections[section]
            if sectionInfo.numberOfObjects > 0 {
                directionsLabel.isHidden = true
                return sectionInfo.numberOfObjects
            } else {
                directionsLabel.isHidden = false
            }
        }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = controller.sections {
            return sections.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    func attemptFetch() {
        let fetchRequest: NSFetchRequest<Goal_Lift> = Goal_Lift.fetchRequest()
        let liftSort = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [liftSort]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        controller.delegate = self
        self.controller = controller
        
        do {
            try self.controller.performFetch()
        } catch {
            let error = error as NSError
            print("\(error)")
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch(type) {
        case.insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        case.delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
        case.update:
            if let indexPath = indexPath {
                let cell = tableView.cellForRow(at: indexPath) as! LiftGoalCell
                configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
            }
            break
        case.move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        }
    }
    
    func generateTestData() {
        let goal1 = Goal_Lift(context: context)
        goal1.name = "Flat Bench Press"
        goal1.weight = 225
        goal1.reps = 10
        goal1.current = 205
        
        let goal2 = Goal_Lift(context: context)
        goal2.name = "Barbell Shoulder Press"
        goal2.weight = 135
        goal2.reps = 10
        goal2.current = 110
        
        let goal3 = Goal_Lift(context: context)
        goal3.name = "Barbell Squat"
        goal3.weight = 205
        goal3.reps = 10
        goal3.current = 195
        
        let goal4 = Goal_Lift(context: context)
        goal4.name = "Power Cleans"
        goal4.weight = 135
        goal4.reps = 10
        goal4.current = 85
        
        let goal5 = Goal_Lift(context: context)
        goal5.name = "Roman Deadlifts"
        goal5.weight = 265
        goal5.reps = 10
        goal5.current = 205
        
        ad.saveContext()
    }

}
