//
//  MenuCollectionViewController.swift
//  Reciparia
//
//  Created by Laura Calinoiu on 28/12/15.
//  Copyright © 2015 3smurfs. All rights reserved.
//

import UIKit

class MenuCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var menuRecipes: [Recipe]!
    @IBOutlet weak var recipeCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        recipeCollection.delegate = self
        recipeCollection.dataSource = self
        navigationItem.title = "Menu"
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("RecipeCell", forIndexPath: indexPath) as! DishRemoverCell
        
        cell.recipe = menuRecipes[indexPath.row]
        cell.recipeName.text = menuRecipes[indexPath.row].name
        cell.remover = self
        return cell
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuRecipes.count
    }
}

extension MenuCollectionViewController: DishRemover{
    func removeRecipeFromMenu(recipe: Recipe){
        menuRecipes.removeAtIndex(menuRecipes.indexOf({$0 == recipe})!)
        self.recipeCollection.reloadData()
    }
}
