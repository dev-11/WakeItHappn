//
//  SearchLocationViewController.swift
//  wakeithappn
//
//  Created by Gokhale, Salil (UK - London) on 6/7/18.
//  Copyright © 2018 Salil Gokhale. All rights reserved.
//

import Foundation
import UIKit
import GooglePlaces

class SearchAddNewViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate, UINavigationControllerDelegate {
    
    var searchItems: [SearchAddressItem] = []
    var startLocation = true
    
    let locationManager = CLLocationManager()
    var location: Location = Location(placeId: "", name: "", formattedAddress: "", coordinates: nil)
    
    // MARK: ViewController Delegate Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Textfield set up
        searchTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        searchTextField.becomeFirstResponder()
        self.hideKeyboardWhenTappedAround()
        
        // Tableview set up
        tableView.rowHeight = 60
        tableView.isHidden = true
        
        // Back button
        setupBackButton()
        
        // Remove tab bar
        self.tabBarController?.tabBar.isHidden = true
        
        // Ask for location
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        navigationController?.delegate = self
        
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if let viewController = viewController as? ConfigurationViewController {
            if (startLocation) {
                viewController.startingLocation = self.location
                viewController.startLocationButton.setTitle(self.location.name, for: .normal)
            } else {
                viewController.finishingLocation = self.location
                viewController.endLocationButton.setTitle(self.location.name, for: .normal)
            }
        }
    }
    
    // MARK: TextView Delegate Methods
    
    @IBOutlet var searchTextField: UITextField!
    
    @objc func textFieldChanged() {
        if let text = searchTextField.text {
            if text.characters.count > 3 {
                var coords: (Double, Double)? = nil
                if CLLocationManager.locationServicesEnabled() {
                    if let location = locationManager.location {
                        coords = (location.coordinate.latitude, location.coordinate.longitude)
                    }
                }
                MapsPlacesService.getPlaces(textInput: text, currentLocation: coords, completion: {(results, error) -> Void in
                    if let results = results {
                        self.searchItems.removeAll()
                        self.tableView.isHidden = false
                        self.searchItems = results
                        self.tableView.reloadData()
                    } else {
                        print(error)
                        // Add Alert Service here
                    }
                })
            } else {
                tableView.isHidden = true
                searchItems.removeAll()
                tableView.reloadData()
            }
        }
    }
    
    // MARK: TableView
    
    @IBOutlet var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "searchViewCell") as? SearchViewCell {
            
            cell.address.text = searchItems[indexPath.row].itemName
            
            return cell
        }
        else {
            return UITableViewCell()
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("You selected cell number: \(indexPath.row)!")
        MapsPlacesService.getPlaceWithId(placeId: self.searchItems[indexPath.row].itemID, completion: {(results, error) -> Void in
//            if let result = results {
            self.location = results
            self.navigationController?.popViewController(animated: true)
            // self.performSegue(withIdentifier: "selectedAddress", sender: self)
//            } else {
//                print(error)
//            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationController = segue.destination as! ConfigurationViewController
        if (startLocation) {
            destinationController.startingLocation = self.location
        } else {
            destinationController.finishingLocation = self.location
        }
    }
    
}
