//
//  RecordsVC.swift
//  MissionPR
//
//  Created by Lane Faison on 6/18/17.
//  Copyright © 2017 Lane Faison. All rights reserved.
//

import UIKit
import CoreData

class RecordsVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var collection: UICollectionView!
    
    var controller: NSFetchedResultsController<Record_Lift>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: " ", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        collection.dataSource = self
        collection.delegate = self

        generateTestData()
        attemptFetch()
        collection.reloadData()
    }
    
    func attemptFetch() {
        let fetchRequest: NSFetchRequest<Record_Lift> = Record_Lift.fetchRequest()
        let recordSort = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [recordSort]
        
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
    
    func configureCell(cell: RecordCell, indexPath: NSIndexPath) {
        let goal = controller.object(at: indexPath as IndexPath)
        cell.configureCell(goal)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "RecordCell", for: indexPath) as? RecordCell
        configureCell(cell: cell!, indexPath: indexPath as NSIndexPath)
        return cell!
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if let sections = controller.sections {
            return sections.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let sections = controller.sections {
            let sectionInfo = sections[section]
            if sectionInfo.numberOfObjects > 0 {
                return sectionInfo.numberOfObjects
            }
        }
        return 0
    }
    
    func generateTestData() {
        let record1 = Record_Lift(context: context)
        record1.name = "Flat Bench Press"
        record1.weight = 225
        record1.reps = 10
        
        let record2 = Record_Lift(context: context)
        record2.name = "Shoulder Barbell Press"
        record2.weight = 135
        record2.reps = 10
        
        let record3 = Record_Lift(context: context)
        record3.name = "Squat"
        record3.weight = 275
        record3.reps = 5
        
        ad.saveContext()
    }
    

}
