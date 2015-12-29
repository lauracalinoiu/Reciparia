//
//  RecipeCell.swift
//  Reciparia
//
//  Created by Laura Calinoiu on 28/12/15.
//  Copyright © 2015 3smurfs. All rights reserved.
//

import UIKit

class RecipeCell: UICollectionViewCell {
    
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var recipe: Recipe!
}

protocol DishAppender{
    func addRecipeToMenu(recipe: Recipe)
}

protocol DishRemover{
    func removeRecipeFromMenu(recipe: Recipe)
}
