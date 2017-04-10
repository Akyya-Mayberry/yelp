//
//  SortCell.swift
//  Yelp
//
//  Created by hollywoodno on 4/9/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

// Allows the ability to capture which of the switch cells had their onSwitch toggled
@objc protocol SortCellDelegate {
    @objc optional func SortCell(sortCell: SortCell, didChangeValue value: Bool)
}

class SortCell: UITableViewCell {
    @IBOutlet weak var switchLabel: UILabel!
    @IBOutlet weak var onSwitch: UISwitch!

    // A class that subclasses SortCellDelegate, optionally declare itself as a delegate
    // and optionally implements it's optional protocol
    weak var delegate: SortCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // Wait for user interaction with switch
        onSwitch.addTarget(self, action: #selector(SortCell.switchValueChanged), for: UIControlEvents.valueChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // User toggled onSwitch
    func switchValueChanged() {
        
        // If I self has a delegate, see if they implemented
        // the optional switchCell function and call it.
        
        delegate?.SortCell?(sortCell: self, didChangeValue: onSwitch.isOn)
    }
}
