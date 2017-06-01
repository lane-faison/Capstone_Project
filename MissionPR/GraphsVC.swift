//
//  GraphsVC.swift
//  MissionPR
//
//  Created by Lane Faison on 5/31/17.
//  Copyright © 2017 Lane Faison. All rights reserved.
//

import UIKit

class GraphsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self


    
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GoalCell", for: indexPath) as! GoalCell
        return cell
    }


}
