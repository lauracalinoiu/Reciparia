//
//  RecipesCollectionViewController.swift
//  Reciparia
//
//  Created by Laura Calinoiu on 28/12/15.
//  Copyright © 2015 3smurfs. All rights reserved.
//

import UIKit

class RecipesCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
   
    @IBOutlet weak var btnRightBadge: MIBadgeButton!
    @IBOutlet var recipesCollectionView: UICollectionView!
    
    var recipes: [Recipe] = [Recipe(name: "Pancakes", imagePath: "", steps: [], ingredients: []),
    Recipe(name: "Caesar Salad", imagePath: "", steps: [], ingredients: []),
    Recipe(name: "Sheperd's pie", imagePath: "", steps: [], ingredients: []),
    Recipe(name: "Crock Pot", imagePath: "", steps: [], ingredients: []),
    Recipe(name: "Mushed potatoes", imagePath: "", steps: [], ingredients: [])]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipesCollectionView.delegate = self
        recipesCollectionView.dataSource = self
        btnRightBadge.badgeString = "5"
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("RecipeCell", forIndexPath: indexPath) as! RecipeCell
        
        cell.recipeName.text = recipes[indexPath.row].name
        return cell
    }

}
