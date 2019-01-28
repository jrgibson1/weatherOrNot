//
//  MoreHoursTVCell.swift
//  weatherOrNot
//
//  Created by John Gibson on 28/1/19.
//  Copyright © 2019 John Gibson. All rights reserved.
//

import UIKit

class MoreHoursTVCell: UITableViewCell {
    @IBOutlet weak var ForecastImage: UIImageView!
    @IBOutlet weak var CurrentTempLabel: UILabel!
    @IBOutlet weak var FeelsLikeLabel: UILabel!
    @IBOutlet weak var SummaryText: UITextView!
    @IBOutlet weak var CloudImage: UIImageView!
    @IBOutlet weak var CloudHeading: UILabel!
    @IBOutlet weak var CloudNumber: UILabel!
    @IBOutlet weak var WindImage: UIImageView!
    @IBOutlet weak var WindHeading: UILabel!
    @IBOutlet weak var WindNumber: UILabel!
    @IBOutlet weak var PrecipImage: UIImageView!
    @IBOutlet weak var PrecipHeading: UILabel!
    @IBOutlet weak var PrecipNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
