//
//  BusinessCell.swift
//  Yelp
//
//  Created by hollywoodno on 4/4/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell {
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var businessNameLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var reviewsLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!

    // Computed based on values returned from controller
    var business: Business! {
        didSet {
            thumbImageView.setImageWith(business.imageURL!)
            businessNameLabel.text = business.name
            ratingImageView.setImageWith(business.ratingImageURL!)
            addressLabel.text = business.address
            reviewsLabel.text = "\(business.reviewCount!) Reviews"
            distanceLabel.text = business.distance
            categoriesLabel.text = business.categories
        }
    }
        
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        thumbImageView.layer.cornerRadius = 3
        thumbImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
