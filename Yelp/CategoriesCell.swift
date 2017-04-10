//
//  CategoriesCell.swift
//  Yelp
//
//  Created by hollywoodno on 4/9/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

// Allows the ability to capture which of the switch cells had their onSwitch toggled
@objc protocol CategoriesCellDelegate {
    @objc optional func CategoriesCell(categoriesCell: CategoriesCell, didChangeValue value: Bool)
}

class CategoriesCell: UITableViewCell {
    @IBOutlet weak var switchLabel: UILabel!
    @IBOutlet weak var onSwitch: UISwitch!

    // A class that subclasses CategoriesCellDelegate, optionally declare itself as a delegate
    // and optionally implements it's optional protocol
    weak var delegate: CategoriesCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // User toggled onSwitch
    func switchValueChanged() {
        
        // If I self has a delegate, see if they implemented
        // the optional categoriesCell function and call it.
        
        delegate?.CategoriesCell?(categoriesCell: self, didChangeValue: onSwitch.isOn)
    }
}
