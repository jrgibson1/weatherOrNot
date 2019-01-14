//
//  AlertsManager.swift
//  weatherOrNot
//
//  Created by John Gibson on 14/10/18.
//  Copyright © 2018 John Gibson. All rights reserved.
//

import Foundation
import UIKit

struct Alert {
    
    private static func showBasicAlert(on vc: UIViewController, with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async { vc.present(alert, animated: true) }
    }
    
    
    static func genericError(on vc: UIViewController) {
        showBasicAlert(on: vc, with: "Oops", message: "Something went wrong, please try again")
    }
    
    static func noLocationSelected(on vc: UIViewController) {
        showBasicAlert(on: vc, with: "No Location Selected", message: "Please go back and select a valid location")
    }
    
    static func noLocationFound(on vc: UIViewController) {
        showBasicAlert(on: vc, with: "No Location Found", message: "Please check the details as there is no location with those parameters")
    }
    
    static func dailyWeather(on vc: UIViewController) {
        showBasicAlert(on: vc, with: "Daily Weather Broke", message: "Fix it")
    }
    
    static func currentWeather(on vc: UIViewController) {
        showBasicAlert(on: vc, with: "Current Weather Broke", message: "Fix it")
    }
    
    static func codingError(on vc: UIViewController) {
        showBasicAlert(on: vc, with: "Feature coming soon", message: "(Promise...Just need to learn to code it!)")
    }
}
