//
//  WUCarInfoCell.swift
//  WeSerVite
//
//  Created by sanjay on 05/08/18.
//  Copyright © 2017 sanjay chauhan. All rights reserved.
//

import UIKit
@IBDesignable
class WUCarInfoCell: UITableViewCell {
  @IBOutlet weak var carNameLabel: UILabel!
  @IBOutlet weak var addressLabel: UILabel!
  @IBOutlet weak var engineType: UILabel!
  @IBOutlet weak var vinLabel: UILabel!
  @IBOutlet weak var fuelLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }
  
  /// Display data on table view cell
  ///
  /// - Parameter data: WUPlaceMark containing all info
  func displayData(data: WUPlaceMark) {
    carNameLabel.text = data.name
    addressLabel.text = data.address
    engineType.text = data.engineType
    vinLabel.text = data.vin
    fuelLabel.text = String(data.fuel)
  }
  
  @IBInspectable var cornerRadius: CGFloat = 0 {
    didSet {
      layer.cornerRadius = cornerRadius
      layer.masksToBounds = cornerRadius > 0
    }
  }
  @IBInspectable var borderWidth: CGFloat = 0 {
    didSet {
      layer.borderWidth = borderWidth
    }
  }
}
