//
//  urlAdd.swift
//  weatherOrNot
//
//  Created by John Gibson on 20/6/18.
//  Copyright © 2018 John Gibson. All rights reserved.
//

import Foundation

extension URL {
    func appendLocationInformation(lat latitude: Double, long longitude: Double) -> URL {
        return self.appendingPathComponent("/\(latitude),\(longitude)")
    }
}
