//
//  MoreHoursTVCell.swift
//  weatherOrNot
//
//  Created by John Gibson on 28/1/19.
//  Copyright © 2019 John Gibson. All rights reserved.
//

import UIKit

class MoreHoursTVCell: UITableViewCell {
    @IBOutlet weak var TimeLabel: UILabel!
    @IBOutlet weak var ForecastImage: UIImageView!
    @IBOutlet weak var CurrentTempLabel: UILabel!
    @IBOutlet weak var FeelsLikeLabel: UILabel!
    @IBOutlet weak var SummaryText: UITextView!
    @IBOutlet weak var CloudImage: UIImageView!
    @IBOutlet weak var CloudNumber: UILabel!
    @IBOutlet weak var WindImage: UIImageView!
    @IBOutlet weak var WindNumber: UILabel!
    @IBOutlet weak var PrecipImage: UIImageView!
    @IBOutlet weak var PrecipNumber: UILabel!
    @IBOutlet weak var FourImage: UIImageView!
    @IBOutlet weak var FourNumber: UILabel!
    @IBOutlet weak var FiveImage: UIImageView!
    @IBOutlet weak var FiveNumber: UILabel!
    @IBOutlet weak var SixImage: UIImageView!
    @IBOutlet weak var SixNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
