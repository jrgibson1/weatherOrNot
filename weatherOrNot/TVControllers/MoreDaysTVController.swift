//
//  MoreDaysTVController.swift
//  weatherOrNot
//
//  Created by John Gibson on 28/1/19.
//  Copyright © 2019 John Gibson. All rights reserved.
//

import UIKit

class MoreDaysTVController: UITableViewController {
    
    var selectedLocation: LocationData?
    var ImportedLocation = [LocationData]()
    var MoreDaysForecast = [DailyWeatherData]()
    //    {
    //        didSet {
    //            self.tableView.reloadData()
    //        }
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        loadWeather()
        applyTheme()
        loadLocation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        applyTheme()
    }
    
    func loadWeather() {
        if let location = selectedLocation {
            ForecastManager.shared.fetchForecast(for: location, completion: { (forecast) in
                if let forecast = forecast {
                    self.MoreDaysForecast = (forecast.daily?.data)!                 }
            })
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return MoreDaysForecast.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 283
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as! MoreDaysTVCell
        let weatherObject = MoreDaysForecast[indexPath.row]
        let now = NSDate(timeIntervalSince1970: TimeInterval(weatherObject.time!))
        let sunrise = NSDate(timeIntervalSince1970: TimeInterval(weatherObject.sunriseTime!))
        let sunset = NSDate(timeIntervalSince1970: TimeInterval(weatherObject.sunsetTime!))
        
        self.navigationItem.title = "Next \(MoreDaysForecast.count) Days"
        
        cell.TimeLabel.text = DateFormatter.localizedString(from: now as Date, dateStyle: .short, timeStyle: .short)
        cell.ForecastImage.image = UIImage(named: weatherObject.icon!)
        cell.CurrentTempLabel.text = "\(Double(weatherObject.temperatureLow!).rounded())° to \(Double(weatherObject.temperatureHigh!).rounded())°"
        cell.SummaryText.text = "\(String(describing: weatherObject.summary!))"
        
        cell.OneImage.image = UIImage(named: "cloud")
        cell.TwoImage.image = UIImage(named: "wind-deg")
        cell.TwoImage.transform = CGAffineTransform(rotationAngle: CGFloat((weatherObject.windBearing)!))
        cell.ThreeImage.image = UIImage(named: "\(weatherObject.precipType ?? "rain")")
        cell.FourImage.image = UIImage(named: "")
        cell.FiveImage.image = UIImage(named: "")
        cell.SixImage.image = UIImage(named: "clear-day")
        
        cell.OneNumber.text = "\(Double((weatherObject.cloudCover!)*100).rounded())%"
        cell.TwoNumber.text = "\(String(describing: (weatherObject.windSpeed!).rounded()))"
        cell.ThreeNumber.text = "\(Double((weatherObject.precipProbability!)*100).rounded())%"
        cell.FourNumber.text = ""
        cell.FiveNumber.text = ""
        cell.SixNumber.text = "\(DateFormatter.localizedString(from: sunrise as Date, dateStyle: .none, timeStyle: .short)) to \(DateFormatter.localizedString(from: sunset as Date, dateStyle: .none, timeStyle: .short))"
        
        cell.ForecastImage.tintColor = Theme.current.imageColour
        cell.OneImage.tintColor = Theme.current.imageColour
        cell.TwoImage.tintColor = Theme.current.imageColour
        cell.ThreeImage.tintColor = Theme.current.imageColour
        cell.FourImage.tintColor = Theme.current.imageColour
        cell.FiveImage.tintColor = Theme.current.imageColour
        cell.SixImage.tintColor = Theme.current.imageColour
        cell.CurrentTempLabel.textColor = Theme.current.textColour
        cell.TimeLabel.textColor = Theme.current.textColour
        cell.SummaryText.textColor = Theme.current.textColour
        cell.OneNumber.textColor = Theme.current.textColour
        cell.TwoNumber.textColor = Theme.current.textColour
        cell.ThreeNumber.textColor = Theme.current.textColour
        cell.FourNumber.textColor = Theme.current.textColour
        cell.FiveNumber.textColor = Theme.current.textColour
        cell.SixNumber.textColor = Theme.current.textColour
        
        return cell
    }
    
    func loadLocation() {
        if let selectedLocation = selectedLocation {
            self.navigationItem.prompt = "\(selectedLocation.locationName)"
        }
    }
    
    func applyTheme() {
        view.backgroundColor = Theme.current.backgroundColour
        navigationController?.navigationBar.tintColor = Theme.current.tintColour
        
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.barTintColor = Theme.current.backgroundColour
        navigationBar?.isTranslucent = false
        navigationBar?.tintColor = Theme.current.textColour
        let miniTheme = [
            NSAttributedString.Key.foregroundColor: Theme.current.textColour
        ]
        navigationBar?.titleTextAttributes = miniTheme
        navigationBar?.largeTitleTextAttributes = miniTheme
        
        let barColor = Theme.current.backgroundColour
        let pressedTintColor = Theme.current.tintColour
        UITabBar.appearance().barTintColor = barColor
        UITabBar.appearance().tintColor = pressedTintColor
    }
    
}
