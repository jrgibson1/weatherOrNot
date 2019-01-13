//
//  DaysTVController.swift
//  weatherOrNot
//
//  Created by John Gibson on 8/1/19.
//  Copyright © 2019 John Gibson. All rights reserved.
//

import UIKit

class DaysTVController: UIViewController {
    
    var selectedLocation: Location?
    var ImportedLocation = [Location]()
    var dailyWeather = [DailyWeatherData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadLocation()
    }
    
    func loadLocation() {
        if let selectedLocation = selectedLocation {
            self.navigationItem.title = "\(selectedLocation.locationName), \(selectedLocation.countryName)"
            
        }
    }
    
}

extension DaysTVController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dailyWeather.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let weatherForecast = dailyWeather[indexPath.section]
        let cell = tableView.dequeueReusableCell(withIdentifier: "DaysView", for: indexPath) as! DaysTVCell
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        cell.weatherImage.image = UIImage(named: weatherForecast.icon!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
}
