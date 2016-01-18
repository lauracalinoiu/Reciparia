//
//  IngredientCell.swift
//  Reciparia
//
//  Created by Laura Calinoiu on 29/12/15.
//  Copyright © 2015 3smurfs. All rights reserved.
//

import UIKit

class IngredientCell: UITableViewCell, CheckboxDelegate{
  @IBOutlet weak var checkbox: CheckBox!
  @IBOutlet weak var unitText: UILabel!
  @IBOutlet weak var ingredientText: UILabel!
  var delegate: IngredientCellDelegate?
  
  override func awakeFromNib() {
    checkbox.delegate = self
  }
  
  func doChange() {
    if let unWrappedDelegate = delegate{
      unWrappedDelegate.doChangeHavingCellIndexPath(self)
    }
  }
}
protocol IngredientCellDelegate{
  func doChangeHavingCellIndexPath(cell: UITableViewCell)
}
