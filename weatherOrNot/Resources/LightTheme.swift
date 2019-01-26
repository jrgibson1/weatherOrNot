//
//  LightTheme.swift
//  weatherOrNot
//
//  Created by John Gibson on 1/1/19.
//  Copyright © 2019 John Gibson. All rights reserved.
//

import UIKit

class LightTheme: ThemeProtocol {
    var statusBar: UIStatusBarStyle = UIStatusBarStyle.default
    
    var signatureImage: UIImage = UIImage(named: "JG-black")!
    
    var barStyle: UIBarStyle = .black
    var preferredStatusBarStyle: UIStatusBarStyle = .default
    
    var imageBackgroundColour: UIColor = UIColor(named: "LightImageBackground")!
    var tableRowSelectionColor: UIColor = UIColor(named: "LightTableRowSelection")!
    var tintColour: UIColor = UIColor(named: "DarkTint")!
    var imageColour: UIColor = UIColor(named: "DarkImage")!
    var backgroundColour: UIColor = UIColor(named: "LightBackground")!
    var textColour: UIColor = UIColor(named: "LightText")!
}
