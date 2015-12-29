//
//  Recipe.swift
//  Reciparia
//
//  Created by Laura Calinoiu on 28/12/15.
//  Copyright © 2015 3smurfs. All rights reserved.
//

import Foundation
struct Recipe: Equatable{
    var name: String
    var imagePath: String
    var steps: [Step]
    var ingredients: [Ingredient]
}

func ==(one: Recipe, second: Recipe) -> Bool{
    return one.name == second.name
}