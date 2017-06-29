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

    
    @IBOutlet weak var recordFilter: UISegmentedControl!
    @IBOutlet weak var table: UITableView!
    
    var controller: NSFetchedResultsController<Record_Lift>!
    var controller2: NSFetchedResultsController<Record_Run>!
    
    var records = [Record_Lift]()
    var records2 = [Record_Run]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false;
        
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: " ", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        recordFilter.layer.cornerRadius = 5
        
        table.dataSource = self
        table.delegate = self

//        generateTestData()
        attemptLiftFetch()
        attemptRunFetch()
    }
    
    func configureLiftCell(cell: RecordLiftCell, indexPath: NSIndexPath) {
        let record = controller.object(at: indexPath as IndexPath)
        cell.configureCell(recordLift: record)
    }
    
    func configureRunCell(cell: RecordRunCell, indexPath: NSIndexPath) {
        let record = controller2.object(at: indexPath as IndexPath)
        cell.configureCell(recordRun: record)
    }
    
    func attemptLiftFetch() {
        let fetchRequest: NSFetchRequest<Record_Lift> = Record_Lift.fetchRequest()
        let recordSort = NSSortDescriptor(key: "timeStamp", ascending: false)
        fetchRequest.sortDescriptors = [recordSort]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        controller.delegate = self
        self.controller = controller
        
        do {
            try self.controller.performFetch()
            let data = self.controller.fetchedObjects
            if (data?.count)! > 0 {
                for record in data! {
                  records.append(record)
                }
            }
            
        } catch {
            let error = error as NSError
            print("\(error)")
        }
    }
    
    func attemptRunFetch() {
        let fetchRequest: NSFetchRequest<Record_Run> = Record_Run.fetchRequest()
        let recordSort = NSSortDescriptor(key: "date", ascending: false)
        fetchRequest.sortDescriptors = [recordSort]
        
        let controller2 = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        controller2.delegate = self
        self.controller2 = controller2
        
        do {
            try self.controller2.performFetch()
            let data = self.controller2.fetchedObjects
            if (data?.count)! > 0 {
                for record in data! {
                    records2.append(record)
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
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = table.dequeueReusableCell(withIdentifier: "RecordLiftCell", for: indexPath) as? RecordLiftCell
            configureLiftCell(cell: cell!, indexPath: indexPath as NSIndexPath)
            return cell!
        }
        
        else {
            let cell = table.dequeueReusableCell(withIdentifier: "RecordRunCell", for: indexPath) as? RecordRunCell
            configureRunCell(cell: cell!, indexPath: indexPath as NSIndexPath)
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            if (editingStyle == UITableViewCellEditingStyle.delete) {
                let recordToDelete = records[indexPath.row]
                print(recordToDelete)
                records.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                context.delete(recordToDelete)
                ad.saveContext()
            }
        }
        else {
            if (editingStyle == UITableViewCellEditingStyle.delete) {
                let recordToDelete = records2[indexPath.row]
                print(recordToDelete)
                records2.remove(at: indexPath.row)
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
        record4.units = "Miles"
        record4.date = Date() as NSDate
        record4.time = 1000
        
        ad.saveContext()
    }
}
