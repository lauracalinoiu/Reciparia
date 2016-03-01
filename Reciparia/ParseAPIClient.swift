//
//  ParseAPIClient.swift
//  Reciparia
//
//  Created by Laura Calinoiu on 05/01/16.
//  Copyright © 2016 3smurfs. All rights reserved.
//

import Foundation
import Parse

class ParseAPIClient{
  
  let NETWORK_INACCESSIBLE = "The network was inaccesible"
  let questionQueryLimit = 100
  
  func getRecipesWithLimit(completionHandler: (result: [Recipe]!, error: String?) -> Void){
    let query = PFQuery(className: "Recipe")
    query.limit = questionQueryLimit
    query.findObjectsInBackgroundWithBlock {
      (objects: [PFObject]?, error: NSError?) -> Void in
      if error == nil {
        if let objectsUnwrapped = objects as? [Recipe]{
          completionHandler(result: objectsUnwrapped, error: nil)
        }
      } else {
        completionHandler(result: nil, error: self.NETWORK_INACCESSIBLE)
      }
    }
  }
  
  func getIngredientsForARecipe(recipe: Recipe, completionHandler: (result: [Ingredient]!, error: String?) -> Void){
    let query = recipe.ingredients.query()
    query.findObjectsInBackgroundWithBlock{results, error in
      if error == nil {
        if let objectsUnwrapped = results as? [Ingredient]{
          completionHandler(result: objectsUnwrapped, error: nil)
        }
      } else {
        completionHandler(result: nil, error: self.NETWORK_INACCESSIBLE)
      }
    }
  }
  
  func getAllIngredients(menuRecipes: [Recipe], result: (ingredients: [Ingredient]) -> Void){
    var ingredients: [Ingredient] = []
    
    let tasks = menuRecipes.map {
      $0.ingredients.query().findObjectsInBackground().continueWithBlock{task in
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
}

extension ParseAPIClient{
  func sync(lock: AnyObject, closure: () -> Void){
    objc_sync_enter(lock)
    closure()
    objc_sync_exit(lock)
  }
}

extension ParseAPIClient{
  class var sharedInstance: ParseAPIClient{
    struct Static{
      static let instance: ParseAPIClient = ParseAPIClient()
    }
    return Static.instance
  }
}