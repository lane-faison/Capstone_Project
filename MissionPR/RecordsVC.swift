//
//  RecordsVC.swift
//  MissionPR
//
//  Created by Lane Faison on 6/18/17.
//  Copyright © 2017 Lane Faison. All rights reserved.
//

import UIKit
import CoreData

class RecordsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {

    
    @IBOutlet weak var tableOfLifts: UITableView!
    @IBOutlet weak var tableOfRuns: UITableView!
    
    var liftController: NSFetchedResultsController<Record_Lift>!
    var runController: NSFetchedResultsController<Record_Run>!
    
    var liftingRecords = [Record_Lift]()
    var runningRecords = [Record_Run]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: " ", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        }
        
        tableOfLifts.dataSource = self
        tableOfLifts.delegate = self
        tableOfRuns.dataSource = self
        tableOfRuns.delegate = self
        
//        generateTestData()
        attemptLiftFetch()
        attemptRunFetch()
    }
    
    func configureLiftCell(cell: RecordLiftCell, indexPath: NSIndexPath) {
        let record = liftController.object(at: indexPath as IndexPath)
        cell.configureCell(recordLift: record)
    }
    
    func configureRunCell(cell: RecordRunCell, indexPath: NSIndexPath) {
        let record = runController.object(at: indexPath as IndexPath)
        cell.configureCell(recordRun: record)
    }
    
    func attemptLiftFetch() {
        let fetchRequest: NSFetchRequest<Record_Lift> = Record_Lift.fetchRequest()
        let recordSort = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [recordSort]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        controller.delegate = self
        self.liftController = controller
        
        do {
            try self.liftController.performFetch()
            let data = self.liftController.fetchedObjects
            if (data?.count)! > 0 {
                for record in data! {
                  liftingRecords.append(record)
                }
            }
        } catch {
            let error = error as NSError
            print("\(error)")
        }
    }
    
    func attemptRunFetch() {
        let fetchRequest: NSFetchRequest<Record_Run> = Record_Run.fetchRequest()
        let recordSort = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [recordSort]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        controller.delegate = self
        self.runController = controller
        
        do {
            try self.runController.performFetch()
            let data = self.runController.fetchedObjects
            if (data?.count)! > 0 {
                for record in data! {
                    runningRecords.append(record)
                }
            }
        } catch {
            let error = error as NSError
            print("\(error)")
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var count = Int()
        
        if tableView == self.tableOfLifts {
            count = liftingRecords.count
        }
        
        else if tableView == self.tableOfRuns {
            count = runningRecords.count
        }
        
        else {
            count = 0
        }
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        if tableView == self.tableOfLifts {
            cell = tableOfLifts.dequeueReusableCell(withIdentifier: "RecordLiftCell", for: indexPath) as! RecordLiftCell
            configureLiftCell(cell: cell as! RecordLiftCell, indexPath: indexPath as NSIndexPath)
        }
        
        if tableView == self.tableOfRuns {
            cell = tableOfRuns.dequeueReusableCell(withIdentifier: "RecordRunCell", for: indexPath) as! RecordRunCell
            configureRunCell(cell: cell as! RecordRunCell, indexPath: indexPath as NSIndexPath)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if tableView == self.tableOfLifts {
            if (editingStyle == UITableViewCell.EditingStyle.delete) {
                let recordToDelete = liftingRecords[indexPath.row]
                print(recordToDelete)
                liftingRecords.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                context.delete(recordToDelete)
                ad.saveContext()
            }
        }
        else {
            if (editingStyle == UITableViewCell.EditingStyle.delete) {
                let recordToDelete = runningRecords[indexPath.row]
                print(recordToDelete)
                runningRecords.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                context.delete(recordToDelete)
                ad.saveContext()
            }
        }
    }
    
    func generateTestData() {
        let record1 = Record_Lift(context: context)
        record1.name = "Flat Bench Press"
        record1.weight = 225
        record1.reps = 10
        record1.timeStamp = Date() as NSDate
        
        let record2 = Record_Lift(context: context)
        record2.name = "Shoulder Barbell Press"
        record2.weight = 135
        record2.reps = 10
        record2.timeStamp = Date() as NSDate
        
        let record3 = Record_Lift(context: context)
        record3.name = "Squat"
        record3.weight = 275
        record3.reps = 5
        record3.timeStamp = Date() as NSDate
        
        let record4 = Record_Run(context: context)
        record4.name = "3 Mile Run"
        record4.distance = 3
        record4.units = "mi"
        record4.date = Date() as NSDate
        record4.time = 1000
        
        ad.saveContext()
    }
}
