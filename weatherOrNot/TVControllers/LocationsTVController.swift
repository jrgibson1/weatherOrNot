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
        cell.flagLabel?.text = location.flag
        cell.flagLabel.textColor = Theme.current.textColour
        cell.locationLabel.text = "\(location.locationName), \(location.countryName)"
        cell.locationLabel.textColor = Theme.current.textColour
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = Theme.current.tableRowSelectionColor
        cell.selectedBackgroundView = backgroundView
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "LocationsToDay", sender: Any.self)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
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
    
    @IBAction func addButtonPressed(_ sender: Any) {
        Alert.codingError(on: self)
    }
    
    func getVersion() -> String {
        let dictionary  = Bundle.main.infoDictionary!
        let version     = dictionary[kVersion] as! String
        let build       = dictionary[kBuildNumber] as! String
        
        return "\(version) (\(build))"
    }
    
}
