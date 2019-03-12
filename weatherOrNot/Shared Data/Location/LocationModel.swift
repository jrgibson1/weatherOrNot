//
//  LocationModel.swift
//  weatherOrNot
//
//  Created by John Gibson on 9/3/19.
//  Copyright © 2019 John Gibson. All rights reserved.
//

import Foundation

class LocationData {
    let id: UUID
    var locationName: String
    var countryName: String
    var latitude: Double    // Sourced from Google.com, www.latlong.net
    var longitude: Double   // Sourced from Google.com, www.latlong.net
    
    init(locationName: String, countryName: String, longitude: Double, latitude: Double) {
        id = UUID()
        self.locationName = locationName
        self.countryName = countryName
        self.latitude = latitude
        self.longitude = longitude
    }
}
