//
//  DarkTheme.swift
//  weatherOrNot
//
//  Created by John Gibson on 1/1/19.
//  Copyright © 2019 John Gibson. All rights reserved.
//

import UIKit

class DarkTheme: ThemeProtocol {
    var barStyle: UIBarStyle = .black
    var preferredStatusBarStyle: UIStatusBarStyle = .lightContent
    
    var imageBackgroundColour: UIColor = UIColor(named: "DarkImageBackground")!
    var tableRowSelectionColor: UIColor = UIColor(named: "DarkTableRowSelection")!
    var tintColour: UIColor = UIColor(named: "LightTint")!
    var imageColour: UIColor = UIColor(named: "LightImage")!
    var backgroundColour: UIColor = UIColor(named: "DarkBackground")!
    var textColour: UIColor = UIColor(named: "DarkText")!
}
