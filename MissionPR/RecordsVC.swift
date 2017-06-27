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

    
    @IBOutlet weak var table: UITableView!
    
    var controller: NSFetchedResultsController<Record_Lift>!
    var records = [Record_Lift]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: " ", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        table.dataSource = self
        table.delegate = self

//        generateTestData()
        attemptFetch()
    }
    
    func configureCell(cell: RecordCell, indexPath: NSIndexPath) {
        let record = controller.object(at: indexPath as IndexPath)
        cell.configureCell(recordLift: record)
    }
    
    func attemptFetch() {
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
//        if let sections = controller.sections {
//            return sections.count
//        }
//        return 0
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "RecordCell", for: indexPath) as? RecordCell
        configureCell(cell: cell!, indexPath: indexPath as NSIndexPath)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            let recordToDelete = records[indexPath.row]
            print(recordToDelete)
            records.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            context.delete(recordToDelete)
            ad.saveContext()
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
        
        ad.saveContext()
    }
    

}
