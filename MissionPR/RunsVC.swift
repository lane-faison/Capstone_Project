//
//  RunsVC.swift
//  MissionPR
//
//  Created by Lane Faison on 6/2/17.
//  Copyright © 2017 Lane Faison. All rights reserved.
//

import UIKit
import CoreData

class RunsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var directionsLabel: UILabel!
    
    var controller: NSFetchedResultsController<Goal_Run>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: " ", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        directionsLabel.isHidden = true
        
//        generateTestData()
        attemptFetch()
    }
    
    func configureCell(cell: RunGoalCell, indexPath: NSIndexPath) {
        let goal = controller.object(at: indexPath as IndexPath)
        cell.configureCell(goalRun: goal)
        cell.configureProgress(goalRun: goal)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RunGoalCell", for: indexPath) as! RunGoalCell
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
            if let destination = segue.destination as? AddRunVC {
                if let goal = sender as? Goal_Run {
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
        let fetchRequest: NSFetchRequest<Goal_Run> = Goal_Run.fetchRequest()
        let runSort = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [runSort]
        
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
                let cell = tableView.cellForRow(at: indexPath) as! RunGoalCell
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
        let goal1 = Goal_Run(context: context)
        goal1.name = "3 Mile Run"
        goal1.currentTime = 1200
        goal1.goalTime = 1100
        goal1.distance = 3
        goal1.units = "mi"
        
        let goal2 = Goal_Run(context: context)
        goal2.name = "1 Mile Run"
        goal2.currentTime = 406
        goal2.goalTime = 359
        goal2.distance = 1
        goal2.units = "mi"
        
        let goal3 = Goal_Run(context: context)
        goal3.name = "BolderBoulder"
        goal3.currentTime = 2803
        goal3.goalTime = 2700
        goal3.distance = 10
        goal3.units = "km"
        
        ad.saveContext()
    }
}

