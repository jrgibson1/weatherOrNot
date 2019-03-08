//
//  LocationsTVController.swift
//  weatherOrNot
//
//  Created by John Gibson on 5/1/19.
//  Copyright © 2019 John Gibson. All rights reserved.
//

import UIKit
import Instabug
import WhatsNewKit

class LocationsTVContoller: UITableViewController {
    let kVersion        = "CFBundleShortVersionString"
    let kBuildNumber    = "CFBundleVersion"
    
    @IBOutlet weak var versionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = editButtonItem
        
        applyTheme()
        whatsNewIfNeeded()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        applyTheme()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func whatsNewIfNeeded() {
        let items = [
            WhatsNew.Item(title: "Welcome", subtitle: "Nulla facilisi. Curabitur finibus eu nisl ut eleifend.", image: UIImage(named: "WhatsNew-Launch")),
            WhatsNew.Item(title: "Powered by Dark Sky", subtitle: "Fusce eget hendrerit nibh. Ut sodales aliquet auctor. Suspendisse vitae gravida nunc.", image: UIImage(named: "WhatsNew-DarkSky")),
            WhatsNew.Item(title: "Bug Fixes", subtitle: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed fermentum fermentum lectus, eu sagittis orci dictum eget.", image: UIImage(named: "WhatsNew-Dev")),
            WhatsNew.Item(title: "Themes", subtitle: "Mauris suscipit ipsum ex, id fermentum risus bibendum ac. Fusce viverra, sem nec dignissim elementum, massa lectus iaculis nisi, eu consectetur dui sapien aliquam nisi.", image: UIImage(named: "WhatsNew-Theme")),
        ]
        
        let myTheme = WhatsNewViewController.Theme { configuration in
            configuration.apply(animation: .fade)
            configuration.itemsView.imageSize = .fixed(height: 30)
            
            configuration.titleView.titleFont = .systemFont(ofSize: 42, weight: .heavy)
            configuration.titleView.secondaryColor = .init(
                startIndex: 11,
                length: 13,
                color: UIColor.whatsNewKitBlue
            )
            
            configuration.detailButton?.title = "Test"
            configuration.detailButton?.titleColor = Theme.current.textColour
            configuration.detailButton?.action = .website(url: "https://www.google.com")
            
            configuration.completionButton.title = "Ok, got it!"
            configuration.completionButton.action = .dismiss
            
            configuration.backgroundColor = Theme.current.backgroundColour
            configuration.titleView.titleColor = Theme.current.textColour
            configuration.itemsView.titleColor = Theme.current.textColour
            configuration.itemsView.subtitleColor = Theme.current.textColour
        }
        
        let myConfig = WhatsNewViewController.Configuration(theme: myTheme)
        
        let whatsNew = WhatsNew(title: "Welcome to \nweatherOrNot", items: items)
        
        let keyValueVersionStore = KeyValueWhatsNewVersionStore(keyValueable: UserDefaults.standard)
        
        let whatsNewVC = WhatsNewViewController(whatsNew: whatsNew, configuration: myConfig, versionStore: keyValueVersionStore)
        
        if let vc = whatsNewVC {
            self.present(vc, animated: true)
        }
        
        //    self.present(whatsNewVC, animated: true)
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
        
        self.versionLabel.text = getVersion()
        self.versionLabel.textColor = Theme.current.textColour
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return locations.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath) as! LocationsTVCell
        let location = locations[indexPath.row]
        
        cell.backgroundColor = Theme.current.backgroundColour
        cell.LocationLabel.text = "\(location.locationName)"
        cell.LocationLabel.textColor = Theme.current.textColour
        
        cell.CountryLabel.text = "\(location.countryName)"
        cell.CountryLabel.textColor = Theme.current.textColour
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = Theme.current.tableRowSelectionColor
        cell.selectedBackgroundView = backgroundView
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "LocationsToDay", sender: Any.self)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        default:
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationVC = segue.destination as! WeatherVController
                destinationVC.selectedLocation = locations[indexPath.row]
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt
        fromIndexPath: IndexPath, to: IndexPath) {
        let movedLocation = locations.remove(at: fromIndexPath.row)
        locations.insert(movedLocation, at: to.row)
        tableView.reloadData()
    }
    
//    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let favourite = UIContextualAction(style: .normal, title: "Favourite") { ( action, view, nil) in
//            print("Favourite set")
//        }
//        favourite.backgroundColor = Theme.current.imageBackgroundColour
//        favourite.image = UIImage(named: "favouriteOutline")
//        
//        let config = UISwipeActionsConfiguration(actions: [favourite])
//        config.performsFirstActionWithFullSwipe = false
//        return config
//    }
    
    func getVersion() -> String {
        let dictionary  = Bundle.main.infoDictionary!
        let version     = dictionary[kVersion] as! String
        let build       = dictionary[kBuildNumber] as! String
        
        return "\(version) (\(build))   "
    }
    
//    @IBAction func addButtonPressed(_ sender: Any) {
//        Alert.codingError(on: self)
//    }
    
}
