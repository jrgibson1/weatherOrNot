//
//  ButtonManager.swift
//  weatherOrNot
//
//  Created by John Gibson on 14/7/18.
//  Copyright © 2018 John Gibson. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    func pulsate() {
        
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.6
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 1
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        
        layer.add(pulse, forKey: "pulse")
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
}
}
