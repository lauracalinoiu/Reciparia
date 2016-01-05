//
//  StepsViewController.swift
//  Reciparia
//
//  Created by Laura Calinoiu on 29/12/15.
//  Copyright © 2015 3smurfs. All rights reserved.
//

import UIKit

class StepsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var stepsTable: UITableView!
    var recipe: Recipe!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        stepsTable.delegate = self
        stepsTable.dataSource = self
        tabBarController?.title = recipe.name
    }


    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("StepCell", forIndexPath: indexPath)
        cell.textLabel!.text = recipe.steps![indexPath.row].text
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipe.steps!.count
    }
}
