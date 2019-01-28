//
//  forecastData.swift
//  weatherOrNot
//
//  Created by John Gibson on 20/6/18.
//  Copyright © 2018 John Gibson. All rights reserved.
//

import Foundation

struct Forecast: Codable {
    var latitude: Double?
    var longitude: Double?
    var currently: Currently?
    var hourly: Hourly?
    var daily: Daily?
    var offset: Int?
}

struct Currently: Codable {
    var apparentTemperature: Double?
    var precipProbability: Double?
    var cloudCover: Double?
    var humidity: Double?
    var summary: String?
    var time: Int?
    var temperature: Double?
    var uvIndex: Int?
    var icon: String?
    var windBearing: Int?
    var windSpeed: Double?
    var dewPoint: Double?
    
    enum CodingKeys: String, CodingKey {
        case time
        case summary
        case temperature
        case windSpeed
        case apparentTemperature
        case windBearing
        case uvIndex
        case icon
        case precipProbability
        case humidity
        case cloudCover
        case dewPoint
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.apparentTemperature = try? valueContainer.decode(Double.self, forKey: CodingKeys.apparentTemperature)
        self.precipProbability = try? valueContainer.decode(Double.self, forKey: CodingKeys.precipProbability)
        self.cloudCover = try? valueContainer.decode(Double.self, forKey: CodingKeys.cloudCover)
        self.humidity = try? valueContainer.decode(Double.self, forKey: CodingKeys.humidity)
        self.summary = try? valueContainer.decode(String.self, forKey: CodingKeys.summary)
        self.time = try valueContainer.decode(Int.self, forKey: CodingKeys.time)
        self.temperature = try? valueContainer.decode(Double.self, forKey: CodingKeys.temperature)
        self.uvIndex = try? valueContainer.decode(Int.self, forKey: CodingKeys.uvIndex)
        self.icon = try valueContainer.decode(String.self, forKey: CodingKeys.icon)
        self.windBearing = try? valueContainer.decode(Int.self, forKey: CodingKeys.windBearing)
        self.windSpeed = try? valueContainer.decode(Double.self, forKey: CodingKeys.windSpeed)
        self.dewPoint = try? valueContainer.decode(Double.self, forKey: CodingKeys.dewPoint)
    }
}

struct Hourly: Codable {
    var summary: String?
    var icon: String
    var data: [HourlyWeatherData]?
}

struct HourlyWeatherData: Codable {
    var time: Int?
    var icon: String?
    var precipIntensity: Double?
    var precipIntensityError: Double?
    var precipProbability: Double?
    var precipType: String?
    var temperature: Double?
    var apparentTemperature: Double?
    var summary: String?
    var cloudCover: Double?
    var windSpeed: Double?
}

struct Daily: Codable {
    var summary: String?
    var icon: String?
    var data: [DailyWeatherData]?
}

struct DailyWeatherData: Codable {
    var cloudCover: Double?
    var icon: String?
    var precipProbability: Double?
    var precipType: String?
    var summary: String?
    var sunriseTime: Double?
    var sunsetTime: Double?
    var temperatureHigh: Double?
    var temperatureLow: Double?
    var time: Double?
    var uvIndex: Int?
    var windBearing: Int?
    var windSpeed: Double?

    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.cloudCover = try? valueContainer.decode(Double.self, forKey: CodingKeys.cloudCover)
        self.icon = try? valueContainer.decode(String.self, forKey: CodingKeys.icon)
        self.precipProbability = try? valueContainer.decode(Double.self, forKey: CodingKeys.precipProbability)
        self.precipType = try? valueContainer.decode(String.self, forKey: CodingKeys.precipType)
        self.summary = try? valueContainer.decode(String.self, forKey: CodingKeys.summary)
        self.sunriseTime = try? valueContainer.decode(Double.self, forKey: CodingKeys.sunriseTime)
        self.sunsetTime = try? valueContainer.decode(Double.self, forKey: CodingKeys.sunsetTime)
        self.temperatureHigh = try? valueContainer.decode(Double.self, forKey: CodingKeys.temperatureHigh)
        self.temperatureLow = try? valueContainer.decode(Double.self, forKey: CodingKeys.temperatureLow)
        self.time = try valueContainer.decode(Double.self, forKey: CodingKeys.time)
        self.uvIndex = try? valueContainer.decode(Int.self, forKey: CodingKeys.uvIndex)
        self.windBearing = try? valueContainer.decode(Int.self, forKey: CodingKeys.windBearing)
        self.windSpeed = try? valueContainer.decode(Double.self, forKey: CodingKeys.windSpeed)
    }
}


extension Currently {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .none
        return formatter
    }()
}

extension DailyWeatherData {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter
    }()
}
