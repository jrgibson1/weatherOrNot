//
//  ThemeProtocol.swift
//  weatherOrNot
//
//  Created by John Gibson on 1/1/19.
//  Copyright © 2019 John Gibson. All rights reserved.
//

import UIKit

protocol ThemeProtocol {
    var backgroundColour: UIColor { get }
    var textColour: UIColor { get }
    var imageColour: UIColor { get }
    var tintColour: UIColor { get }
    var imageBackgroundColour: UIColor { get }
    
    var tableRowSelectionColor: UIColor { get }
}
