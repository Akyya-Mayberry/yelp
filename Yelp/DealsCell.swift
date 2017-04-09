//
//  DealsCell.swift
//  Yelp
//
//  Created by hollywoodno on 4/9/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol DealsCellDelegate {
    @objc optional func DealsCell(dealsCell: DealsCell, didChangeValue value: Bool)
}

class DealsCell: UITableViewCell {

    @IBOutlet weak var onSwitch: UISwitch!
    @IBOutlet weak var switchLabel: UILabel!
    weak var delegate: DealsCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // Wait for user interaction with switch
        onSwitch.addTarget(self, action: #selector(DealsCell.switchValueChanged), for: UIControlEvents.valueChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // User toggled onSwitch
    func switchValueChanged() {
        
        // If I self has a delegate, see if they implemented
        // the optional switchCell function and call it.
        
        delegate?.DealsCell?(dealsCell: self, didChangeValue: onSwitch.isOn)
    }
    
}
