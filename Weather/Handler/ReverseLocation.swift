//
//  ReverseLocation.swift
//  Weather
//
//  Created by Joakim Kajan on 11.09.2019.
//  Copyright © 2019 JapeSoft. All rights reserved.
//

import MapKit

class ReverseLocation {
    
    func getPlace(location: CLLocation, label: UILabel) {
        
        var city = String()
        var country = String()
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in guard self != nil else { return }
            
            if let _ = error {
                // Show alert informing the user
            }

            guard let placemark = placemarks?.first else {
                return
            }
            
            city = placemark.locality ?? ""
            country = placemark.country ?? ""

            DispatchQueue.main.async {
                label.text = "\(city), \(country)"
            }
        }
    }
}



