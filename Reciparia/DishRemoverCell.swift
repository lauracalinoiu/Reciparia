//
//  DishRemoverCell.swift
//  Reciparia
//
//  Created by Laura Calinoiu on 29/12/15.
//  Copyright © 2015 3smurfs. All rights reserved.
//


import UIKit
class DishRemoverCell: RecipeCell{
    var remover: DishRemover!
  
    @IBAction func removeButtonPressed(sender: UIButton) {
        remover.removeRecipeFromMenu(recipe)
    }
}