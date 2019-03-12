//
//  LocationFunction.swift
//  weatherOrNot
//
//  Created by John Gibson on 9/3/19.
//  Copyright © 2019 John Gibson. All rights reserved.
//

import Foundation

class LocationFunctions {
    static func createLocation(locationModel: LocationData) {
        
    }
    
    static func readLocations(completion: @escaping () -> ()) {
        DispatchQueue.global(qos: .userInteractive).async {
            if Data.locationModels.count == 0 {
                Data.locationModels.append(LocationData(locationName: "Apple Park", countryName: "United States of America", longitude: -122.010980, latitude: 37.332280))
                Data.locationModels.append(LocationData(locationName: "Boston", countryName: "United States of America", longitude: -71.0583, latitude: 42.3603))
                Data.locationModels.append(LocationData(locationName: "Cape Town", countryName: "South Africa", longitude: 18.4174, latitude: -33.929))
                Data.locationModels.append(LocationData(locationName: "Melbourne", countryName: "Australia", longitude: 144.963058, latitude: -37.813629))
                Data.locationModels.append(LocationData(locationName: "Sydney", countryName: "Australia", longitude: 151.209290, latitude: -33.868820))
                Data.locationModels.append(LocationData(locationName: "Vancouver", countryName: "Canada", longitude: -123.1155, latitude: 49.2624))
            }
            DispatchQueue.main.async {
                completion()
            }
        }
        
    }
    
    static func updateLocation(locationModel: LocationData) {
        
    }
    
    static func deleteLocation(locationModel: LocationData) {
        
    }
}
