//
//  IngredientCell.swift
//  Reciparia
//
//  Created by Laura Calinoiu on 29/12/15.
//  Copyright © 2015 3smurfs. All rights reserved.
//

import UIKit

class IngredientCell: UITableViewCell, CheckboxDataSource{
  @IBOutlet weak var checkbox: CheckBox!
  @IBOutlet weak var unitText: UILabel!
  @IBOutlet weak var ingredientText: UILabel!
  var delegate: IngredientCellDelegate?
  
  func getCellIndexPath() -> NSIndexPath{
    return delegate!.getCellIndexPath(self)
  }
}
protocol IngredientCellDelegate{
  func getCellIndexPath(cell: UITableViewCell) -> NSIndexPath
}
