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
    @IBOutlet weak var windImage: UIImageView!
    @IBOutlet weak var windHeading: UILabel!
    @IBOutlet weak var windNumber: UILabel!
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
    @IBOutlet weak var tapMoreHoursButton: UIButton!
    @IBOutlet weak var next24HoursLabel: UILabel!
    @IBOutlet weak var daySummaryText: UITextView!
    @IBOutlet weak var dailyWeatherCollection: UICollectionView!
    @IBOutlet weak var tapMoreDaysButton: UIButton!
    
    var selectedLocation: Location?
    var ImportedLocation = [Location]()
    var hourlyWeather = [HourlyWeatherData]() {
        didSet {
            self.hourlyWeatherCollection.reloadData()
        }
    }
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProgressHUD()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard selectedLocation != nil else {return Alert.noLocationSelected(on: self)}

        loadLocation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        applyTheme()
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
                        self.dateLabel.text = DateFormatter.localizedString(from: now as Date, dateStyle: .full, timeStyle: .none)
                        self.currentForecastImage.image = UIImage(named: currentForecast!.icon!)
                        self.currentTempLabel.text = "\(Double(currentForecast!.temperature!).rounded())°"
                        self.currentSummary.text = "\(currentForecast!.summary!)"
                        self.feelsLikeNumber.text = "\((currentForecast!.apparentTemperature!).rounded())°"
                        self.humidityNumber.text = "\(Double((currentForecast!.humidity!)*100).rounded())%"
                        self.uvIndexNumber.text = "\(Double(currentForecast!.uvIndex!).rounded())"
                        self.windImage.image = UIImage(named: "wind-deg")
                        self.windImage.transform = CGAffineTransform(rotationAngle: CGFloat((currentForecast?.windBearing!)!))
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
                        self.sunSetNumber.text = DateFormatter.localizedString(from: sunset as Date, dateStyle: .none, timeStyle: .short)
                        self.sunRiseNumber.text = DateFormatter.localizedString(from: sunrise as Date, dateStyle: .none, timeStyle: .short)
                        self.daySummaryText.text = "\(dailyForecast.summary!)"
                        self.windNumber.text = "\(String(describing: (dailyForecast.data![0].windSpeed!).rounded()))"
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
        navigationBar?.titleTextAttributes = miniTheme
        navigationBar?.largeTitleTextAttributes = miniTheme
        setNeedsStatusBarAppearanceUpdate()
        
        let barColor = Theme.current.backgroundColour
        let pressedTintColor = Theme.current.tintColour
        UITabBar.appearance().barTintColor = barColor
        UITabBar.appearance().tintColor = pressedTintColor

        self.dateLabel.textColor = Theme.current.textColour
        self.currentTempLabel.textColor = Theme.current.textColour
        self.variableTempLabel.textColor = Theme.current.textColour
        self.currentSummary.textColor = Theme.current.textColour
        self.windNumber.textColor = Theme.current.textColour
        self.windImage.tintColor = Theme.current.imageColour
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
        self.tapMoreHoursButton.setTitleColor(Theme.current.textColour, for: .normal) 
        self.next24HoursLabel.textColor = Theme.current.textColour
        self.daySummaryText.textColor = Theme.current.textColour
        self.tapMoreDaysButton.setTitleColor(Theme.current.textColour, for: .normal) 
        self.windHeading.textColor = Theme.current.textColour
        
        self.feelsLikeImage.backgroundColor = Theme.current.imageBackgroundColour
        self.humidityImage.backgroundColor = Theme.current.imageBackgroundColour
        self.cloudImage.backgroundColor = Theme.current.imageBackgroundColour
        self.precipChanceImage.backgroundColor = Theme.current.imageBackgroundColour
        self.uvIndexImage.backgroundColor = Theme.current.imageBackgroundColour
        self.sunRiseImage.backgroundColor = Theme.current.imageBackgroundColour
        self.sunSetImage.backgroundColor = Theme.current.imageBackgroundColour
        self.windImage.backgroundColor = Theme.current.imageBackgroundColour
    }
    
    func LabelNames() {
        self.moreDetailsLabel.text = "RIGHT NOW"
        self.sunRiseImage.image = UIImage(named: "sunrise")
        self.sunRiseImage.layer.cornerRadius = self.sunSetImage.frame.height / 2
        self.sunRiseHeading.text = "Sunrise"
        self.sunSetImage.image = UIImage(named: "sunset")
        self.sunSetImage.layer.cornerRadius = self.sunSetImage.frame.height / 2
        self.sunSetHeading.text = "Sunset"
        self.feelsLikeImage.image = UIImage(named: "thermometer")
        self.feelsLikeImage.layer.cornerRadius = feelsLikeImage.frame.height / 2
        self.feelsLikeHeading.text = "Feels Like"
        self.cloudImage.image = UIImage(named: "cloud")
        self.cloudImage.layer.cornerRadius = self.cloudImage.frame.height / 2
        self.cloudHeading.text = "Cloud \nCoverage"
        self.humidityImage.image = UIImage(named: "humidity")
        self.humidityImage.layer.cornerRadius = feelsLikeImage.frame.height / 2
        self.humidityHeading.text = "Humidity"
        self.uvIndexImage.image = UIImage(named: "clear-day")
        self.uvIndexImage.layer.cornerRadius = feelsLikeImage.frame.height / 2
        self.uvIndexHeading.text = "UV Index"
        self.windHeading.text = "Wind Speed"
        self.windImage.layer.cornerRadius = self.sunSetImage.frame.height / 2
        self.precipChanceImage.layer.cornerRadius = self.precipChanceImage.frame.height / 2
        self.thisHourLabel.text = "NEXT 24 HOURS"
        self.next24HoursLabel.text = "NEXT 7 DAYS"
        self.tapMoreHoursButton.setTitle("TAP HERE FOR MORE DETAILS", for: .normal)
        self.tapMoreDaysButton.setTitle("TAP HERE FOR MORE DETAILS", for: .normal)
    }
    
    @IBAction func gestureTapped(_ sender: UITapGestureRecognizer) {
        print("Hello, world!")
//        if sender.state == .ended {
//            var currentTheme: ThemeState = .LightTheme {
//                Theme.current = ThemeState == .LightTheme ? LightTheme() : DarkTheme()
//        }
//
    }
    
    @IBAction func favouriteNavBarButtonTapped(_ sender: Any) {
        Alert.codingError(on: self)
    }
    
}

extension WeatherVController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return hourlyWeather.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let weatherForecast = hourlyWeather[indexPath.section]
        let time = NSDate(timeIntervalSince1970: TimeInterval(weatherForecast.time!))
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourlyCVCell", for: indexPath) as! HourlyCVCell
        cell.TimeLabel.text = DateFormatter.localizedString(from: time as Date, dateStyle: .none, timeStyle: .short)
        cell.WeatherIcon.image = UIImage(named: weatherForecast.icon!)
        cell.TempLabel.text = "\((weatherForecast.temperature!).rounded())°"
        let precipProbability = ((weatherForecast.precipProbability!)*100)
        let roundedPrecip = precipProbability.roundToPlaces(places: 1)
        cell.precipLabel.text = "\(roundedPrecip)%"
        
        
        
        
                cell.TempLabel.textColor = Theme.current.textColour
                cell.WeatherIcon.tintColor = Theme.current.imageColour
                cell.precipLabel.textColor = Theme.current.textColour
                cell.TimeLabel.textColor = Theme.current.textColour
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WeatherToMoreHours" {
                let destinationVC = segue.destination as! MoreHoursTVController
            navigationItem.title = "Back"
                destinationVC.selectedLocation = selectedLocation
    } else if segue.identifier == "WeatherToMoreDays" {
                let destinationVC = segue.destination as! MoreDaysTVController
            navigationItem.title = "Back"
                destinationVC.selectedLocation = selectedLocation
            }
        }
}

extension Double {
    
    func roundToPlaces(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
}
