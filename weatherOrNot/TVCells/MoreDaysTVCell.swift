//
//  MoreDaysTVCell.swift
//  weatherOrNot
//
//  Created by John Gibson on 28/1/19.
//  Copyright © 2019 John Gibson. All rights reserved.
//

import UIKit

class MoreDaysTVCell: UITableViewCell {
    @IBOutlet weak var TimeLabel: UILabel!
    @IBOutlet weak var ForecastImage: UIImageView!
    @IBOutlet weak var CurrentTempLabel: UILabel!
    @IBOutlet weak var SummaryText: UITextView!
    @IBOutlet weak var OneImage: UIImageView!
    @IBOutlet weak var OneNumber: UILabel!
    @IBOutlet weak var TwoImage: UIImageView!
    @IBOutlet weak var TwoNumber: UILabel!
    @IBOutlet weak var ThreeImage: UIImageView!
    @IBOutlet weak var ThreeNumber: UILabel!
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
