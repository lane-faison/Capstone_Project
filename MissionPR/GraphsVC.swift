//
//  GraphsVC.swift
//  MissionPR
//
//  Created by Lane Faison on 5/31/17.
//  Copyright © 2017 Lane Faison. All rights reserved.
//

import UIKit
import CoreData

class GraphsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var controller: NSFetchedResultsController<Goal_Lift>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

//        generateTestData()
        attemptFetch()
    
    }
    
    func configureCell(cell: LiftGoalCell, indexPath: NSIndexPath) {
        // update cell
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
            return sectionInfo.numberOfObjects
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
                // update the cell data
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
        goal1.weight = 315
        goal1.reps = 1
        goal1.current = 275
        
        let goal2 = Goal_Lift(context: context)
        goal2.name = "Back Squat"
        goal2.weight = 275
        goal2.reps = 10
        goal2.current = 205
        
        let goal3 = Goal_Lift(context: context)
        goal3.name = "Deadlift"
        goal3.weight = 500
        goal3.reps = 1
        goal3.current = 365
        
        let goal4 = Goal_Lift(context: context)
        goal4.name = "Barbell Curl"
        goal4.weight = 135
        goal4.reps = 1
        goal4.current = 105
        
        let goal5 = Goal_Lift(context: context)
        goal5.name = "Weighted Pullups"
        goal5.weight = 45
        goal5.reps = 10
        goal5.current = 30
        
        ad.saveContext()
    }

}
