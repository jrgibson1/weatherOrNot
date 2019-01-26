//
//  SettingsVController.swift
//  weatherOrNot
//
//  Created by John Gibson on 25/1/19.
//  Copyright © 2019 John Gibson. All rights reserved.
//

import UIKit

class SettingsVController: UIViewController {
    @IBOutlet weak var darkModeLabel: UILabel!
    @IBOutlet weak var lightToDarkSwitcher: UISwitch!
    @IBOutlet weak var signatureImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyTheme()
        
        if let themeSwicher = defaults.value(forKey: "LightTheme") {
            lightToDarkSwitcher.isOn = themeSwicher as! Bool
        }
    }
    
    let defaults = UserDefaults.standard
    
    func applyTheme() {
        view.backgroundColor = Theme.current.backgroundColour
        navigationController?.navigationBar.tintColor = Theme.current.tintColour
        
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.barTintColor = Theme.current.backgroundColour
        navigationBar?.isTranslucent = false
        navigationBar?.tintColor = Theme.current.textColour
        let miniTheme = [
            NSAttributedString.Key.foregroundColor: Theme.current.textColour
        ]
        navigationBar?.titleTextAttributes = miniTheme
        navigationBar?.largeTitleTextAttributes = miniTheme
        
        let barColor = Theme.current.backgroundColour
        let pressedTintColor = Theme.current.tintColour
        UITabBar.appearance().barTintColor = barColor
        UITabBar.appearance().tintColor = pressedTintColor
        
        darkModeLabel.textColor = Theme.current.textColour
        
        self.signatureImage.image = Theme.current.signatureImage
    }
    
    @IBAction func switchTapped(_ sender: UISwitch) {
        Theme.current = sender.isOn ? LightTheme() : DarkTheme()
        
        defaults.set(sender.isOn, forKey: "LightTheme")
        applyTheme()
    }
    
    
    
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
