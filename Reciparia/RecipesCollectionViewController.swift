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

class RecipesCollectionViewController: UIViewController{
  
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
    loadRecipesFromParse{(recipes: [Recipe]) -> Void in
      self.recipes = recipes
      self.recipesCollectionView.reloadData()
    }
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "ToTheMenu"{
      let destination = segue.destinationViewController as! UITabBarController
      let firstVCFromTab = destination.viewControllers![0] as! MenuCollectionViewController
      firstVCFromTab.menuRecipes = menuRecipes
      firstVCFromTab.menuUpdater = self
      
      let secondVCFromTab = destination.viewControllers![1] as! IngredientsViewController
      ParseAPIClient.sharedInstance.getAllIngredients(menuRecipes){ (ingredients: [Ingredient]) -> Void in
        secondVCFromTab.ingredients = [ingredients, []]
      }
    }
  }
  
  
  func loadRecipesFromParse(setUpOnUI: (recipes: [Recipe]) -> Void){
    ParseAPIClient.sharedInstance.getRecipesWithLimit{ results, error in
      guard error == nil else {
        return
      }
      guard results != nil else {
        return
      }
      setUpOnUI(recipes: results)
    }
  }
}

extension RecipesCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate{
  
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
