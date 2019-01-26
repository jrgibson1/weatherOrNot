//
//  WhatsNewKit.swift
//  weatherOrNot
//
//  Created by John Gibson on 25/1/19.
//  Copyright © 2019 John Gibson. All rights reserved.
//

import Foundation
import WhatsNewKit

func whatsNewIfNeeded() {
    let items = [
        WhatsNew.Item(title: "Welcome", subtitle: "Nulla facilisi. Curabitur finibus eu nisl ut eleifend.", image: UIImage(named: "WhatsNew-Launch")),
        WhatsNew.Item(title: "Powered by Dark Sky", subtitle: "Fusce eget hendrerit nibh. Ut sodales aliquet auctor. Suspendisse vitae gravida nunc.", image: UIImage(named: "WhatsNew-DarkSky")),
        WhatsNew.Item(title: "Bug Fixes", subtitle: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed fermentum fermentum lectus, eu sagittis orci dictum eget.", image: UIImage(named: "WhatsNew-Dev")),
        WhatsNew.Item(title: "Themes", subtitle: "Mauris suscipit ipsum ex, id fermentum risus bibendum ac. Fusce viverra, sem nec dignissim elementum, massa lectus iaculis nisi, eu consectetur dui sapien aliquam nisi.", image: UIImage(named: "WhatsNew-Theme")),
        ]
    
    let myTheme = WhatsNewViewController.Theme { configuration in
        configuration.apply(animation: .fade)
        configuration.itemsView.imageSize = .fixed(height: 30)
        
        configuration.titleView.titleFont = .systemFont(ofSize: 42, weight: .heavy)
        configuration.titleView.secondaryColor = .init(
            startIndex: 11,
            length: 13,
            color: UIColor.whatsNewKitBlue
        )
        
        configuration.detailButton?.title = "Test"
        configuration.detailButton?.titleColor = Theme.current.textColour
        configuration.detailButton?.action = .website(url: "https://www.google.com")
        
        configuration.completionButton.title = "Ok, got it!"
        configuration.completionButton.action = .dismiss
        
        configuration.backgroundColor = Theme.current.backgroundColour
        configuration.titleView.titleColor = Theme.current.textColour
        configuration.itemsView.titleColor = Theme.current.textColour
        configuration.itemsView.subtitleColor = Theme.current.textColour
    }
    
    let myConfig = WhatsNewViewController.Configuration(theme: myTheme)
    
    let whatsNew = WhatsNew(title: "Welcome to \nweatherOrNot", items: items)
    
    let whatsNewVC = WhatsNewViewController(whatsNew: whatsNew, configuration: myConfig)
    
    //        if let vc = whatsNewVC {
    //            self.present(vc, animated: true)
    //        }
    
//    self.present(whatsNewVC, animated: true)
}
