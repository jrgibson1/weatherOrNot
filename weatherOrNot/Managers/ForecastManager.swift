//
//  ForecastManager.swift
//  weatherOrNot
//
//  Created by John Gibson on 20/6/18.
//  Copyright © 2018 John Gibson. All rights reserved.
//

import Foundation

class ForecastManager {
    
    static let shared = ForecastManager()
    
    func fetchForecast(for location: LocationData, completion: @escaping (Forecast?) -> Void) {
        if let url = URL(string: "https://api.darksky.net/forecast/a509ddba8c1bd6e27c66364a8d0d01a0?units=ca")?.appendLocationInformation(lat: location.latitude, long: location.longitude) {
            let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if let data = data {
                    let jsonDecoder = JSONDecoder()
                    let forecast = try? jsonDecoder.decode(Forecast.self, from: data)
                    completion(forecast)
                }
            })
            task.resume()
        }
    }
}

