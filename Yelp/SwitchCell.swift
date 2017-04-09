//
//  SwitchCell.swift
//  Yelp
//
//  Created by hollywoodno on 4/6/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

// Allows the ability to capture which of the switch cells had their onSwitch toggled
@objc protocol SwitchCellDelegate {
    @objc optional func SwitchCell(switchCell: SwitchCell, didChangeValue value: Bool)
}

class SwitchCell: UITableViewCell {
    @IBOutlet weak var switchLabel: UILabel!
    @IBOutlet weak var onSwitch: UISwitch!

    // If a controller specifies itself as a delegate of
    // SwitchCell, it can choose to implement the SwitchCellDelegate
    // protocol which will allow it do get events of a SwitchCell's onSwitch activity
    
    // A class that subclasses SwitchCellDelegate, optionally declare itself as a delegate
    // and optionally implements it's optional protocol
    weak var delegate: SwitchCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Wait for user interaction with switch
        onSwitch.addTarget(self, action: #selector(SwitchCell.switchValueChanged), for: UIControlEvents.valueChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // User toggled onSwitch
    func switchValueChanged() {
        print("switch value has changed!")
        
        // If I self has a delegate, see if they implemented
        // the optional switchCell function and call it.

        delegate?.SwitchCell?(switchCell: self, didChangeValue: onSwitch.isOn)
    }
}
