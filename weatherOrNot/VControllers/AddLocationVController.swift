//
//  AddLocationVController.swift
//  weatherOrNot
//
//  Created by John Gibson on 16/2/19.
//  Copyright © 2019 John Gibson. All rights reserved.
//

import UIKit

class AddLocationVController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyTheme()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        applyTheme()
    }
    
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
        setNeedsStatusBarAppearanceUpdate()
        
        let barColor = Theme.current.backgroundColour
        let pressedTintColor = Theme.current.tintColour
        UITabBar.appearance().barTintColor = barColor
        UITabBar.appearance().tintColor = pressedTintColor
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
