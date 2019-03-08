//
//  MoreHoursTVController.swift
//  weatherOrNot
//
//  Created by John Gibson on 28/1/19.
//  Copyright © 2019 John Gibson. All rights reserved.
//

import UIKit

class MoreHoursTVController: UITableViewController {
    
    var selectedLocation: Location?
    var ImportedLocation = [Location]()
    var MoreHoursForecast = [HourlyWeatherData](){
        didSet {
            self.tableView.reloadData()
        }
    }
    
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
                    self.MoreHoursForecast = (forecast.hourly?.data)!                 }
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
        return MoreHoursForecast.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 283
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as! MoreHoursTVCell
        let weatherObject = MoreHoursForecast[indexPath.row]
        let now = NSDate(timeIntervalSince1970: TimeInterval(weatherObject.time!))
        
        self.navigationItem.title = "Next \(MoreHoursForecast.count) Hours"

        cell.TimeLabel.text = DateFormatter.localizedString(from: now as Date, dateStyle: .short, timeStyle: .short)
        cell.ForecastImage.image = UIImage(named: weatherObject.icon!)
        cell.CurrentTempLabel.text = "\(Double(weatherObject.temperature!).rounded())°"
        cell.FeelsLikeLabel.text = "Feels Like \(Double(weatherObject.apparentTemperature!).rounded())°"
        cell.SummaryText.text = weatherObject.summary
        cell.CloudNumber.text = "\(Double((weatherObject.cloudCover!)*100).rounded())%"
        cell.WindNumber.text = "\(String(describing: (weatherObject.windSpeed!).rounded()))"
        cell.PrecipNumber.text = "\(Double((weatherObject.precipIntensity!)*100).rounded())%"
        
        cell.CloudImage.image = UIImage(named: "cloud")
        cell.PrecipImage.image = UIImage(named: "\(weatherObject.precipType ?? "rain")")
        cell.WindImage.image = UIImage(named: "wind-deg")
        cell.WindImage.transform = CGAffineTransform(rotationAngle: CGFloat((weatherObject.windBearing)!))
        
        cell.FourImage.image = UIImage(named: "humidity")
        cell.FiveImage.image = UIImage(named: "uv")
        cell.SixImage.image = UIImage(named: "visability")
        
        cell.FourNumber.text = "\(Double((weatherObject.humidity!)*100).rounded())%"
        cell.FiveNumber.text = "\(String(Int(weatherObject.uvIndex!)))"
        cell.SixNumber.text = "\((weatherObject.visibility!).rounded())"
        
        
        cell.ForecastImage.tintColor = Theme.current.imageColour
        cell.CloudImage.tintColor = Theme.current.imageColour
        cell.WindImage.tintColor = Theme.current.imageColour
        cell.PrecipImage.tintColor = Theme.current.imageColour
        cell.FourImage.tintColor = Theme.current.imageColour
        cell.FiveImage.tintColor = Theme.current.imageColour
        cell.SixImage.tintColor = Theme.current.imageColour
        cell.CurrentTempLabel.textColor = Theme.current.textColour
        cell.FeelsLikeLabel.textColor = Theme.current.textColour
        cell.TimeLabel.textColor = Theme.current.textColour
        cell.SummaryText.textColor = Theme.current.textColour
        cell.CloudNumber.textColor = Theme.current.textColour
        cell.WindNumber.textColor = Theme.current.textColour
        cell.PrecipNumber.textColor = Theme.current.textColour
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
