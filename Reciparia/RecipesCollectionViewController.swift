//
//  RecipesCollectionViewController.swift
//  Reciparia
//
//  Created by Laura Calinoiu on 28/12/15.
//  Copyright © 2015 3smurfs. All rights reserved.
//

import UIKit
import Bolts
import Parse

class RecipesCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
  
  @IBOutlet weak var btnRightBadge: MIBadgeButton!
  @IBOutlet var recipesCollectionView: UICollectionView!
  
  var recipes: [Recipe] = []
  
  var menuRecipes: [Recipe] = []{
    didSet{
      btnRightBadge.badgeString = "\(menuRecipes.count)"
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    recipesCollectionView.delegate = self
    recipesCollectionView.dataSource = self
    btnRightBadge.badgeString = "_"
    loadRecipesFromParse()
  }
  
  func loadRecipesFromParse(){
    ParseAPIClient.sharedInstance.getQuestionsWithLimit{[unowned self] results, error in
      guard error == nil else {
        return
      }
      guard results != nil else {
        return
      }
      
      self.recipes = results
      self.recipesCollectionView.reloadData()
    }
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return recipes.count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("RecipeCell", forIndexPath: indexPath) as! DishAppenderCell
    
    cell.recipeName.text = recipes[indexPath.row].name
    cell.recipe = recipes[indexPath.row]
    cell.appender = self
    return cell
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "ToTheMenu"{
      let destination = segue.destinationViewController as! UITabBarController
      let firstVCFromTab = destination.viewControllers![0] as! MenuCollectionViewController
      firstVCFromTab.menuRecipes = menuRecipes
      firstVCFromTab.menuUpdater = self
      
      let secondVCFromTab = destination.viewControllers![1] as! IngredientsViewController
      getAllIngredients(){ (ingredients: [Ingredient]) -> Void in
        secondVCFromTab.ingredients = ingredients
      }
    }
  }
  
  func sync(lock: AnyObject, closure: () -> Void){
    objc_sync_enter(lock)
    closure()
    objc_sync_exit(lock)
  }
  
  func getAllIngredients(result: (ingredients: [Ingredient]) -> Void){
    var ingredients: [Ingredient] = []
    
    let tasks = menuRecipes.map { $0.toIngredients.query().findObjectsInBackground().continueWithBlock{task in
      if let objectsUnwrapped = task.result as? [Ingredient]{
        self.sync(ingredients){
          ingredients.appendContentsOf(objectsUnwrapped)
        }
      }
      return task
      }
    }
    
    let aggregateTask = BFTask(forCompletionOfAllTasks: tasks)
    aggregateTask.continueWithBlock{ task in
      if (task.error == nil) {
        result(ingredients: ingredients)
      }
      return nil
    }
  }
  
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let tabbarController = storyboard.instantiateViewControllerWithIdentifier("RecipeTabBarController") as! UITabBarController
    let recipeVC = tabbarController.viewControllers![0] as! RecipeViewController
    recipeVC.recipe = recipes[indexPath.row]
    
    let stepsVC = tabbarController.viewControllers![1] as! StepsViewController
    stepsVC.recipe = recipes[indexPath.row]
    navigationController?.pushViewController(tabbarController, animated: true)
  }
}

extension RecipesCollectionViewController : DishAppender {
  func addRecipeToMenu(recipe: Recipe){
    menuRecipes.append(recipe)
  }
}

extension RecipesCollectionViewController: MenuUpdater{
  func updateMenu(menuRecipes: [Recipe]) {
    self.menuRecipes = menuRecipes
  }
}
