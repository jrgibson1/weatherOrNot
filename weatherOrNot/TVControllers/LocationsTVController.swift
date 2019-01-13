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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = editButtonItem
        
        applyTheme()
//        whatsNewIfNeeded()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func whatsNewIfNeeded() {
        let items = [
            WhatsNew.Item(title: "Powered by Dark Sky", subtitle: "Fusce eget hendrerit nibh. Ut sodales aliquet auctor. Suspendisse vitae gravida nunc.", image: UIImage(named: "WhatsNew-DarkSky")),
            WhatsNew.Item(title: "Bug Fixes", subtitle: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed fermentum fermentum lectus, eu sagittis orci dictum eget.", image: UIImage(named: "WhatsNew-Dev")),
            WhatsNew.Item(title: "Themes", subtitle: "Mauris suscipit ipsum ex, id fermentum risus bibendum ac. Fusce viverra, sem nec dignissim elementum, massa lectus iaculis nisi, eu consectetur dui sapien aliquam nisi.", image: UIImage(named: "WhatsNew-Theme")),
            WhatsNew.Item(title: "Weather", subtitle: "Nulla facilisi. Curabitur finibus eu nisl ut eleifend.", image: UIImage(named: "WhatsNew-Weather")),
            ]
        
        let myTheme = WhatsNewViewController.Theme { configuration in
            configuration.apply(animation: .fade)
            configuration.completionButton.title = "Ok, got it!"
            configuration.completionButton.action = .dismiss
            configuration.itemsView.imageSize = .fixed(height: 50)
            
            configuration.titleView.titleFont = .systemFont(ofSize: 42, weight: .heavy)
            configuration.titleView.secondaryColor = .init(
                startIndex: 11,
                length: 13,
                color: UIColor.whatsNewKitBlue
            )
            
            configuration.backgroundColor = Theme.current.backgroundColour
            configuration.titleView.titleColor = Theme.current.textColour
            configuration.itemsView.titleColor = Theme.current.textColour
            configuration.itemsView.subtitleColor = Theme.current.textColour
        }
        
        
        
        let myConfig = WhatsNewViewController.Configuration(theme: myTheme)
        
        let whatsNew = WhatsNew(title: "Welcome to \nweatherOrNot", items: items)
        
        let whatsNewVC = WhatsNewViewController(whatsNew: whatsNew, configuration: myConfig)
        
//        if let vc = whatsNewVC {
//            self.present(vc, animated: true)
//        }
        
        self.present(whatsNewVC, animated: true)
    }
    
    func applyTheme() {
        view.backgroundColor = Theme.current.backgroundColour
        navigationController?.navigationBar.tintColor = Theme.current.tintColour
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
        
    }
    
}
