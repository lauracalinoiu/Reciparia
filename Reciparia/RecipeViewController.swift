//
//  RecipeViewController.swift
//  Reciparia
//
//  Created by Laura Calinoiu on 29/12/15.
//  Copyright © 2015 3smurfs. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var ingredients: UITableView!
    var recipe: Recipe!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ingredients.delegate = self
        ingredients.dataSource = self
        tabBarController?.title = recipe.name
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipe.ingredients!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("IngredientCell", forIndexPath: indexPath) as! IngredientCellPlain
        cell.quantityUnit.text = "\(recipe.ingredients![indexPath.row].amount) "+recipe.ingredients![indexPath.row].unit!
        cell.ingredientName.text = recipe.ingredients![indexPath.row].ingredient
        
        return cell
    }
}
