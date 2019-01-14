//
//  WeatherVController.swift
//  weatherOrNot
//
//  Created by John Gibson on 30/5/18.
//  Copyright © 2018 John Gibson. All rights reserved.
//

import UIKit
import Instabug
import SVProgressHUD

class WeatherVController: UIViewController {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var variableTempLabel: UILabel!
    @IBOutlet weak var currentSummary: UITextView!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var windCompassImage: UIImageView!
    @IBOutlet weak var currentForecastImage: UIImageView!
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    @IBOutlet weak var moreDetailsLabel: UILabel!
    @IBOutlet weak var feelsLikeImage: UIImageView!
    @IBOutlet weak var feelsLikeHeading: UILabel!
    @IBOutlet weak var feelsLikeNumber: UILabel!
    @IBOutlet weak var humidityImage: UIImageView!
    @IBOutlet weak var humidityHeading: UILabel!
    @IBOutlet weak var humidityNumber: UILabel!
    @IBOutlet weak var cloudImage: UIImageView!
    @IBOutlet weak var cloudHeading: UILabel!
    @IBOutlet weak var cloudNumber: UILabel!
    @IBOutlet weak var precipChanceImage: UIImageView!
    @IBOutlet weak var precipChanceHeading: UILabel!
    @IBOutlet weak var precipChanceNumber: UILabel!
    @IBOutlet weak var uvIndexImage: UIImageView!
    @IBOutlet weak var uvIndexHeading: UILabel!
    @IBOutlet weak var uvIndexNumber: UILabel!
    @IBOutlet weak var sunRiseImage: UIImageView!
    @IBOutlet weak var sunRiseHeading: UILabel!
    @IBOutlet weak var sunRiseNumber: UILabel!
    @IBOutlet weak var sunSetImage: UIImageView!
    @IBOutlet weak var sunSetHeading: UILabel!
    @IBOutlet weak var sunSetNumber: UILabel!
    @IBOutlet weak var thisHourLabel: UILabel!
    @IBOutlet weak var hourSummary: UITextView!
    @IBOutlet weak var hourlyWeatherCollection: UICollectionView!
    @IBOutlet weak var tapMoreHoursLabel: UILabel!
    @IBOutlet weak var next24HoursLabel: UILabel!
    @IBOutlet weak var daySummaryText: UITextView!
    @IBOutlet weak var dailyWeatherCollection: UICollectionView!
    @IBOutlet weak var tapMoreDaysLabel: UILabel!
    
    var selectedLocation: Location?
    var ImportedLocation = [Location]()
    var hourlyWeather = [HourlyWeatherData]() {
        didSet {
            self.hourlyWeatherCollection.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProgressHUD()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard selectedLocation != nil else {return Alert.noLocationSelected(on: self)}

        loadLocation()
    }
    
    func ProgressHUD() {
        SVProgressHUD.show(withStatus: "Loading \(String(describing: selectedLocation!.locationName)) weather...")
        
        DispatchQueue.main.async(execute: {
            self.loadCurrentWeather()
            self.loadHourlyWeather()
            self.loadDailyWeather()
            
            self.LabelNames()
            self.applyTheme()
            })
        
        SVProgressHUD.dismiss()
    }
    
    func loadLocation() {
        if let selectedLocation = selectedLocation {
            self.navigationItem.title = "\(selectedLocation.locationName)"
        }
    }
    
    // °C
    
    func loadCurrentWeather() {
        if let location = selectedLocation {
            ForecastManager.shared.fetchForecast(for: location, completion: { (forecast) in
                if let forecast = forecast {
                    let currentForecast = forecast.currently
                    let now = NSDate(timeIntervalSince1970: TimeInterval(currentForecast!.time!))
                    DispatchQueue.main.async(execute: {
                        self.dateLabel.text = Currently.dateFormatter.string(from: now as Date)
                        self.currentForecastImage.image = UIImage(named: currentForecast!.icon!)
                        self.currentTempLabel.text = "\(Double(currentForecast!.temperature!).rounded())°"
                        self.currentSummary.text = "\(currentForecast!.summary!)"
                        self.feelsLikeNumber.text = "\((currentForecast!.apparentTemperature!).rounded())°"
                        self.humidityNumber.text = "\(Double((currentForecast!.humidity!)*100).rounded())%"
                        self.uvIndexNumber.text = "\(Double(currentForecast!.uvIndex!).rounded())"
                        self.windCompassImage.image = UIImage(named: "wind-deg")
                        self.windCompassImage.transform = CGAffineTransform(rotationAngle: CGFloat((currentForecast?.windBearing!)!))
                    })
                }
            })
        }
    }
    
    func loadHourlyWeather() {
        if let location = selectedLocation {
            ForecastManager.shared.fetchForecast(for: location, completion: { (forecast) in
                if let forecast = forecast {
                    let hourlyForecast = forecast.hourly
                    DispatchQueue.main.async(execute: {
                        self.hourSummary.text = "\(hourlyForecast!.summary!)"
                        if let hourlyWeather = hourlyForecast?.data {
                            self.hourlyWeather = hourlyWeather
                        }
                    })
                }
            })
        }
    }
    
    func loadDailyWeather() {
        if let location = selectedLocation {
            ForecastManager.shared.fetchForecast(for: location, completion: { (forecast) in
                if let forecast = forecast {
                    let dailyForecast = forecast.daily!
                    let sunrise = NSDate(timeIntervalSince1970: TimeInterval(dailyForecast.data![0].sunriseTime!))
                    let sunset = NSDate(timeIntervalSince1970: TimeInterval(dailyForecast.data![0].sunsetTime!))
                    DispatchQueue.main.async(execute: {
                        self.variableTempLabel.text = "\(Int((dailyForecast.data![0].temperatureLow!).rounded()))° / \(Int((dailyForecast.data![0].temperatureHigh!).rounded()))°"
                        self.cloudNumber.text = "\(Double((dailyForecast.data![0].cloudCover!)*100).rounded())%"
                        self.precipChanceHeading.text = "Chance of \n\((dailyForecast.data![0].precipType)?.capitalized ?? "rain")"
                        self.precipChanceImage.image = UIImage(named: "\(dailyForecast.data![0].precipType ?? "rain")")
                        self.precipChanceNumber.text = "\(Double((dailyForecast.data![0].precipProbability!)*100).rounded())%"
                        self.sunSetNumber.text = DailyWeatherData.dateFormatter.string(from: sunset as Date)
                        self.sunRiseNumber.text = DailyWeatherData.dateFormatter.string(from: sunrise as Date)
                        self.daySummaryText.text = "\(dailyForecast.summary!)"
                        self.windLabel.text = "Wind \(String(describing: (dailyForecast.data![0].windSpeed!).rounded()))"
                    })
                }
            })
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
        navigationBar?.largeTitleTextAttributes = miniTheme
        
        self.dateLabel.textColor = Theme.current.textColour
        self.currentTempLabel.textColor = Theme.current.textColour
        self.variableTempLabel.textColor = Theme.current.textColour
        self.currentSummary.textColor = Theme.current.textColour
        self.windLabel.textColor = Theme.current.textColour
        self.windCompassImage.tintColor = Theme.current.imageColour
        self.currentForecastImage.tintColor = Theme.current.imageColour
        self.moreDetailsLabel.textColor = Theme.current.textColour
        self.feelsLikeImage.tintColor = Theme.current.imageColour
        self.feelsLikeHeading.textColor = Theme.current.textColour
        self.feelsLikeNumber.textColor = Theme.current.textColour
        self.humidityImage.tintColor = Theme.current.imageColour
        self.humidityHeading.textColor = Theme.current.textColour
        self.humidityNumber.textColor = Theme.current.textColour
        self.cloudImage.tintColor = Theme.current.imageColour
        self.cloudHeading.textColor = Theme.current.textColour
        self.cloudNumber.textColor = Theme.current.textColour
        self.precipChanceImage.tintColor = Theme.current.imageColour
        self.precipChanceHeading.textColor = Theme.current.textColour
        self.precipChanceNumber.textColor = Theme.current.textColour
        self.uvIndexImage.tintColor = Theme.current.imageColour
        self.uvIndexHeading.textColor = Theme.current.textColour
        self.uvIndexNumber.textColor = Theme.current.textColour
        self.sunRiseImage.tintColor = Theme.current.imageColour
        self.sunRiseHeading.textColor = Theme.current.textColour
        self.sunRiseNumber.textColor = Theme.current.textColour
        self.sunSetImage.tintColor = Theme.current.imageColour
        self.sunSetHeading.textColor = Theme.current.textColour
        self.sunSetNumber.textColor = Theme.current.textColour
        self.thisHourLabel.textColor = Theme.current.textColour
        self.hourSummary.textColor = Theme.current.textColour
        self.tapMoreHoursLabel.textColor = Theme.current.textColour
        self.next24HoursLabel.textColor = Theme.current.textColour
        self.daySummaryText.textColor = Theme.current.textColour
        self.tapMoreDaysLabel.textColor = Theme.current.textColour
//        self.CellTimeLabel.textColor = Theme.current.textColour
//        self.CellWeatherImage.tintColor = Theme.current.imageColour
//        self.CellTempLabel.textColor = Theme.current.textColour
//        self.CellPrecipLabel.textColor = Theme.current.textColour
        
        self.feelsLikeImage.backgroundColor = Theme.current.imageBackgroundColour
        self.humidityImage.backgroundColor = Theme.current.imageBackgroundColour
        self.cloudImage.backgroundColor = Theme.current.imageBackgroundColour
        self.precipChanceImage.backgroundColor = Theme.current.imageBackgroundColour
        self.uvIndexImage.backgroundColor = Theme.current.imageBackgroundColour
        self.sunRiseImage.backgroundColor = Theme.current.imageBackgroundColour
        self.sunSetImage.backgroundColor = Theme.current.imageBackgroundColour
    }
    
    func LabelNames() {
        self.moreDetailsLabel.text = "RIGHT NOW"
        self.feelsLikeHeading.text = "Feels Like"
        self.feelsLikeImage.image = UIImage(named: "thermometer")
        self.feelsLikeImage.layer.cornerRadius = feelsLikeImage.frame.height / 2
        self.humidityHeading.text = "Humidity"
        self.humidityImage.image = UIImage(named: "humidity")
        self.humidityImage.layer.cornerRadius = feelsLikeImage.frame.height / 2
        self.uvIndexHeading.text = "UV Index"
        self.uvIndexImage.image = UIImage(named: "clear-day")
        self.uvIndexImage.layer.cornerRadius = feelsLikeImage.frame.height / 2
        self.cloudImage.image = UIImage(named: "cloud")
        self.cloudHeading.text = "Cloud \nCoverage"
        self.cloudImage.layer.cornerRadius = self.cloudImage.frame.height / 2
        self.cloudImage.layer.cornerRadius = self.cloudImage.frame.height / 2
        self.precipChanceImage.layer.cornerRadius = self.precipChanceImage.frame.height / 2
        self.sunSetImage.image = UIImage(named: "sunset")
        self.sunSetHeading.text = "Sunset"
        self.sunSetImage.layer.cornerRadius = self.sunSetImage.frame.height / 2
        self.sunRiseImage.image = UIImage(named: "sunrise")
        self.sunRiseHeading.text = "Sunrise"
        self.sunRiseImage.layer.cornerRadius = self.sunSetImage.frame.height / 2
        self.thisHourLabel.text = "NEXT 24 HOURS"
        self.next24HoursLabel.text = "NEXT 7 DAYS"
        self.tapMoreHoursLabel.text = "TAP ABOVE FOR MORE INFORMATION"
        self.tapMoreDaysLabel.text = "TAP ABOVE FOR MORE DETAILS"
    }
    
    @IBAction func switchTapped(_ sender: UISwitch) {
        Theme.current = sender.isOn ? LightTheme() : DarkTheme()
        
        UserDefaults.standard.set(sender.isOn, forKey: "LightTheme")
        applyTheme()
    }
    
    @IBAction func gestureTapped(_ sender: UITapGestureRecognizer) {
        print("Hello, world!")
//        if sender.state == .ended {
//            var currentTheme: ThemeState = .LightTheme {
//                Theme.current = ThemeState == .LightTheme ? LightTheme() : DarkTheme()
//        }
//
    }
}

extension WeatherVController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourlyWeather.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let weatherForecast = hourlyWeather[indexPath.section]
        let time = NSDate(timeIntervalSince1970: TimeInterval(weatherForecast.time!))
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourlyCVCell", for: indexPath) as! HourlyCVCell
        cell.WeatherIcon.image = UIImage(named: weatherForecast.icon!)
        cell.TempLabel.text = "\((weatherForecast.temperature!).rounded())°"
        cell.precipLabel.text = "\((weatherForecast.precipProbability!)*100)%"
        cell.TimeLabel.text = DateFormatter.localizedString(from: time as Date, dateStyle: .none, timeStyle: .short)
        
        return cell
    }
}
