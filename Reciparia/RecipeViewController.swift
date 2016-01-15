//
//  RecipeViewController.swift
//  Reciparia
//
//  Created by Laura Calinoiu on 29/12/15.
//  Copyright © 2015 3smurfs. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var ingredientsTableView: UITableView!
  var recipe: Recipe!
  var ingredients: [Ingredient] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    ingredientsTableView.delegate = self
    ingredientsTableView.dataSource = self
    tabBarController?.title = recipe.name
    
    let query = recipe.toIngredients.query()
    query.findObjectsInBackgroundWithBlock{results, error in
      if error == nil {
        if let objectsUnwrapped = results as? [Ingredient]{
          self.ingredients.appendContentsOf(objectsUnwrapped)
          self.ingredientsTableView.reloadData()
        }
      }
    }
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return ingredients.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("IngredientCell", forIndexPath: indexPath) as! IngredientCellPlain
    if let amount = ingredients[indexPath.row].amount, let unit = ingredients[indexPath.row].unit{
      cell.quantityUnit.text = "\(amount) \(unit)"
    }
    
    if let ingredientName = ingredients[indexPath.row].ingredient{
      cell.ingredientName.text = ingredientName
    }
    
    return cell
  }
}
