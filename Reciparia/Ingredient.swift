//
//  Ingredient.swift
//  Reciparia
//
//  Created by Laura Calinoiu on 28/12/15.
//  Copyright © 2015 3smurfs. All rights reserved.
//

import Foundation
import Parse

class Ingredient: PFObject, PFSubclassing{
    
    class func parseClassName() -> String {
        return "Ingredient"
    }
 
    @NSManaged var category: String?
    @NSManaged var name: String?
    @NSManaged var quantity: NSNumber?
    @NSManaged var unit: String?
}