//
//  locationData.swift
//  weatherOrNot
//
//  Created by John Gibson on 28/5/18.
//  Copyright © 2018 John Gibson. All rights reserved.
//

import Foundation

struct Location: Codable {
    
    var locationName: String
    var countryName: String
    var countryAbbreviation: String
    var flag: String
    var latitude: Double    // Sourced from Google.com, www.latlong.net
    var longitude: Double   // Sourced from Google.com, www.latlong.net
    
    init(locationName: String, countryName: String, countryAbbreviation: String, flag: String, longitude: Double, latitude: Double) {
        self.locationName = locationName
        self.countryName = countryName
        self.countryAbbreviation = countryAbbreviation
        self.flag = flag
        self.latitude = latitude
        self.longitude = longitude
    }
}

var locations: [Location] = [
    Location(locationName: "Apple Park", countryName: "United States of America", countryAbbreviation: "USA", flag: "", longitude: -122.010980, latitude: 37.332280),
    Location(locationName: "Barcelona", countryName: "Spain", countryAbbreviation: "ESP", flag: "🇪🇸", longitude: 2.1774, latitude: 41.3829),
    Location(locationName: "Beijing", countryName: "China", countryAbbreviation: "CHN", flag: "🇨🇳", longitude: 116.3912, latitude: 39.906),
    Location(locationName: "Berlin", countryName: "Germany", countryAbbreviation: "DEU", flag: "🇩🇪", longitude: 13.3889, latitude: 52.517),
    Location(locationName: "Boston", countryName: "United States of America", countryAbbreviation: "USA", flag: "🇺🇸", longitude: -71.0583, latitude: 42.3603),
    Location(locationName: "Brisbane", countryName: "Australia", countryAbbreviation: "AUS", flag: "🇦🇺", longitude: 153.025131, latitude: -27.469770),
    Location(locationName: "Budapest", countryName: "Hungary", countryAbbreviation: "HUN", flag: "🇭🇺", longitude: 19.0405, latitude: 47.4984),
    Location(locationName: "Buenos Aires", countryName: "Argentina", countryAbbreviation: "ARG", flag: "🇦🇷", longitude: -58.4371, latitude: -34.6076),
    Location(locationName: "Cape Town", countryName: "South Africa", countryAbbreviation: "RSA", flag: "🇿🇦", longitude: 18.4174, latitude: -33.929),
    Location(locationName: "Chicago", countryName: "United States of America", countryAbbreviation: "USA", flag: "🇺🇸", longitude: -87.6244, latitude: 41.878114),
    Location(locationName: "Dublin", countryName: "Ireland", countryAbbreviation: "IRL", flag: "🇮🇪", longitude: -6.2603, latitude: 53.3498),
    Location(locationName: "Hong Kong", countryName: "Hong Kong", countryAbbreviation: "HKG", flag: "🇭🇰", longitude: 114.109497, latitude: 22.396428),
    Location(locationName: "Istanbul", countryName: "Turkey", countryAbbreviation: "TUR", flag: "🇹🇷", longitude: 28.9652, latitude: 41.0096),
    Location(locationName: "London", countryName: "Great Britain", countryAbbreviation: "GBR", flag: "🇬🇧", longitude: -0.1276, latitude: 51.5073),
    Location(locationName: "Melbourne", countryName: "Australia", countryAbbreviation: "AUS", flag: "🇦🇺", longitude: 144.963058, latitude: -37.813629),
//    Location(locationName: "nil", countryName: "nil", countryAbbreviation: "ZIP", flag: "🏳️‍🌈", longitude: 404.4, latitude: 24601),
    Location(locationName: "New York City", countryName: "United States of America", countryAbbreviation: "USA", flag: "🇺🇸", longitude: -73.9866, latitude: 40.7306),
    Location(locationName: "Prague", countryName: "Czech Republic", countryAbbreviation: "CZE", flag: "🇨🇿", longitude: 14.4213, latitude: 50.0875),
    Location(locationName: "Rio de Janeiro", countryName: "Brazil", countryAbbreviation: "BRA", flag: "🇧🇷", longitude: -42.4194, latitude: -22.2753),
    Location(locationName: "Rome", countryName: "Italy", countryAbbreviation: "ITA", flag: "🇮🇹", longitude: 12.4829, latitude: 41.8933),
    Location(locationName: "San Francisco", countryName: "United States of America", countryAbbreviation: "USA", flag: "🇺🇸", longitude: -122.4192, latitude: 37.7793),
    Location(locationName: "Singapore", countryName: "Singapore", countryAbbreviation: "SGP", flag: "🇸🇬", longitude: 103.852, latitude: 1.2905),
    Location(locationName: "Sydney", countryName: "Australia", countryAbbreviation: "AUS", flag: "🇦🇺", longitude: 151.209290, latitude: -33.868820),
    Location(locationName: "Tokyo", countryName: "Japan", countryAbbreviation: "JPN", flag: "🇯🇵", longitude: 139.4049, latitude: 34.6969),
    Location(locationName: "Vancouver", countryName: "Canada", countryAbbreviation: "CAN", flag: "🇨🇦", longitude: -123.1155, latitude: 49.2624),
    Location(locationName: "Venice", countryName: "Italy", countryAbbreviation: "ITA", flag: "🇮🇹", longitude: 12.3346, latitude: 45.4372),
]
