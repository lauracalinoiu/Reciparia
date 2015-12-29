//
//  DishAppenderCell.swift
//  Reciparia
//
//  Created by Laura Calinoiu on 29/12/15.
//  Copyright © 2015 3smurfs. All rights reserved.
//

import UIKit
class DishAppenderCell: RecipeCell{
    var appender: DishAppender!
    
    @IBAction func addButtonPressed(sender: UIButton) {
        appender.addRecipeToMenu(recipe)
    }
}