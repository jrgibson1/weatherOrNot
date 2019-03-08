//
//  FavouriteManager.swift
//  weatherOrNot
//
//  Created by John Gibson on 11/7/18.
//  Copyright © 2018 John Gibson. All rights reserved.
//

import Foundation
import UIKit

enum ForecastType: String {
    case currently = "current"
    case daily = "day"
    case weekly = "week"
}

class FavouriteManager {
    let defaults = UserDefaults.standard
    
    static let shared = FavouriteManager()
    
    func saveLocation(location: Location?) {
        if let location = location {
            let locationDictionary: [String: Any?] = [
                "locationName": location.locationName,
                "countryName": location.countryName,
                "longitude": location.longitude,
                "latitude": location.latitude]
            defaults.set(locationDictionary, forKey: "location")
        }
    }
    
    func saveForecast(forecast: ForecastType) {
        defaults.set(forecast.rawValue, forKey: "forecastType")
    }
    
    func retrieveLocation() -> Location? {
        if let locationDictionary = defaults.value(forKey: "location") as? [String: Any?] {
            if let locationName = locationDictionary["locationName"] as? String,
                let countryName = locationDictionary["countryName"] as? String,
                let longitude = locationDictionary["longitude"] as? Double,
                let latitude = locationDictionary["latitude"] as? Double {
                return Location(locationName: locationName, countryName: countryName, longitude: longitude, latitude: latitude)
            }
        }
        return nil
    }
    
    func retrieveForecast() -> ForecastType? {
        if let favouriteForecastString = defaults.value(forKey: "forecastType") as? String {
            return ForecastType(rawValue: favouriteForecastString)
        }
        return nil
    }
    
    func deleteAllFavourites() {
        defaults.removeObject(forKey: "forecast")
        defaults.removeObject(forKey: "location")
        defaults.removeObject(forKey: "forecastType")
    }
}
