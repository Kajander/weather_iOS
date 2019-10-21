//
//  LocationSearchBar.swift
//  Weather
//
//  Created by Joakim Kajan on 02.10.2019.
//  Copyright © 2019 JapeSoft. All rights reserved.
//

import UIKit

class LocationSearchBar: UISearchBar, UISearchBarDelegate {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSearchBar()

    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSearchBar()
    }
    
    func setupSearchBar() {
        
        placeholder = " Add new location "
        searchBarStyle = .minimal
        backgroundColor = .clear
        
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self

    }
    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        // Ignoring user
//        UIApplication.shared.beginIgnoringInteractionEvents()
//
//        //Activity Indicator
//        let activityIndicator = UIActivityIndicatorView()
//        activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
//        //activityIndicator.center = self.view.center
//        activityIndicator.hidesWhenStopped = true
//        activityIndicator.startAnimating()
//        //view.addSubview(activityIndicator)
//
//        // Hide searchbar
//        searchBar.resignFirstResponder()
//        dismiss(animated: true, completion: nil)
//
//        // Create search request
//        let searchRequest = MKLocalSearch.Request()
//        searchRequest.naturalLanguageQuery = searchBar.text
//
//
//        let activeSearch = MKLocalSearch(request: searchRequest)
//        activeSearch.start { (response, error) in
//
//            // Stop animation
//            activityIndicator.stopAnimating()
//            UIApplication.shared.endIgnoringInteractionEvents()
//
//            if response != nil {
//
//                // Get latitude and longitude from the location user has entered
//                let latitude = response?.mapItems.first?.placemark.coordinate.latitude
//                let longitude = response?.mapItems.first?.placemark.coordinate.longitude
//
//                self.coordinate.lat = latitude!
//                self.coordinate.long = longitude!
//                self.searchedLocation = searchBar.text!
//
//                // Get weather information needed for the weatherView
//                self.getCurrentWeather(latitude: latitude!, longitude: longitude!)
//                self.getDailyWeather(latitude: latitude!, longitude: longitude!)
//
//            }else{
//
//                print("Error: No response (activeSearch")
//            }
//        }
//    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
                
    }
    */
    
}
