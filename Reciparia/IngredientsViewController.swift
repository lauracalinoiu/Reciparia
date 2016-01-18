//
//  IngredientsViewController.swift
//  Reciparia
//
//  Created by Laura Calinoiu on 29/12/15.
//  Copyright © 2015 3smurfs. All rights reserved.
//

import UIKit

class IngredientsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  @IBOutlet weak var ingredientsTableView: UITableView!
  var ingredients: [[Ingredient]] = [[]]
  let headerTitles = ["To buy", "Got'em"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    ingredientsTableView.delegate = self
    ingredientsTableView.dataSource = self
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("IngredientCell", forIndexPath: indexPath) as! IngredientCell
    cell.delegate = self
    
    cell.checkbox.isChecked = indexPath.section == 1
    if let amount = ingredients[indexPath.section][indexPath.row].amount {
      cell.unitText.text = "\(amount)"
    }
    if let unit = ingredients[indexPath.section][indexPath.row].unit{
      cell.unitText.text = cell.unitText.text! + "  \(unit)"
    }
    cell.ingredientText.text = ingredients[indexPath.section][indexPath.row].ingredient
    return cell
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return ingredients[section].count
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return ingredients.count
  }
  
  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return headerTitles[section]
  }
}

extension IngredientsViewController: IngredientCellDelegate{
  func doChangeHavingCellIndexPath(cell: UITableViewCell){
    let fromIndexPath = ingredientsTableView.indexPathForCell(cell)!
    let fromSection = fromIndexPath.section
    let toSection = 1 - fromSection
    let toIndexPath = NSIndexPath(forRow: 0, inSection: toSection)
    
    let dataPiece = ingredients[fromIndexPath.section][fromIndexPath.row]
    ingredients[toIndexPath.section].insert(dataPiece, atIndex: toIndexPath.row)
    ingredients[fromIndexPath.section].removeAtIndex(fromIndexPath.row)
    
    ingredientsTableView.moveRowAtIndexPath(fromIndexPath, toIndexPath: toIndexPath)
  }
}
