//
//  RecipesCollectionViewController.swift
//  Reciparia
//
//  Created by Laura Calinoiu on 28/12/15.
//  Copyright © 2015 3smurfs. All rights reserved.
//

import UIKit

class RecipesCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
   
    @IBOutlet weak var btnRightBadge: MIBadgeButton!
    @IBOutlet var recipesCollectionView: UICollectionView!
    
    var recipes: [Recipe] = [Recipe(name: "Pancakes", imagePath: "", steps: [Step(text: "Mix milk, eggs and flour"), Step(text: "Put little oil in pan")], ingredients: []),
    Recipe(name: "Caesar Salad", imagePath: "", steps: [], ingredients: []),
    Recipe(name: "Sheperd's pie", imagePath: "", steps: [], ingredients: []),
    Recipe(name: "Crock Pot", imagePath: "", steps: [], ingredients: []),
    Recipe(name: "Mushed potatoes", imagePath: "", steps: [], ingredients: [])]
    
    var menuRecipes: [Recipe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipesCollectionView.delegate = self
        recipesCollectionView.dataSource = self
        btnRightBadge.badgeString = "_"
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
        }
    }
}

extension RecipesCollectionViewController : DishAppender {
    func addRecipeToMenu(recipe: Recipe){
        menuRecipes.append(recipe)
        btnRightBadge.badgeString = "\(menuRecipes.count)"
    }
}
