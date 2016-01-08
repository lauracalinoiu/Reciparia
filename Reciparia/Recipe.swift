//
//  Recipe.swift
//  Reciparia
//
//  Created by Laura Calinoiu on 28/12/15.
//  Copyright © 2015 3smurfs. All rights reserved.
//
import Foundation
import Parse


class Recipe: PFObject, PFSubclassing{
  
  class func parseClassName() -> String {
    return "Recipe"
  }
  
  // MARK: - Parse Core Properties
  @NSManaged var name: String?
  @NSManaged var pic: String?
  @NSManaged var steps: [Step]?
  var toIngredients: PFRelation! {
    return relationForKey("ingredients")
  }
}
