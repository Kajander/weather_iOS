//
//  CurrentWeatherViewController.swift
//  Weather
//
//  Created by Joakim Kajan on 28.02.2019.
//  Copyright © 2019 JapeSoft. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import CoreData


class MainViewController: UIViewController, UISearchBarDelegate {
    
    var searchedLocation = ""
    
    let addButton = AddButton()
    let locationSearchBar = LocationSearchBar()
    
    let stackView = UIStackView()
    
    var coordinate: (lat: Double, long: Double) = (0.0,0.0)
    var long: Double = 0.0
    var lat: Double = 0.0
    
    var sunriseList = [Date]()
    var sunsetList = [Date]()
    var dailyTimeList = [Date]()
    var dailyIconList = [String]()
    var dailyMinTemp = [String]()
    var dailyMaxTemp = [String]()
    
    var isOn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textFieldAppearance = UITextField.appearance()
        textFieldAppearance.keyboardAppearance = .dark
        view.backgroundColor = .white
        
        setupBackGround()
        setupStackView()
        setupAddButton()

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //loadLocations()
    }
    
    
    
    //MARK: - Setup
    
    
    func setupBackGround() {
        
        let backGroundView = MainBackgroundView()
        backGroundView.frame = CGRect(x: view.frame.origin.x, y: view.frame.origin.y, width: view.frame.width, height: view.frame.height)
        backGroundView.backgroundColor = UIColor.white
        backGroundView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backGroundView)
        backGroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backGroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backGroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backGroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setupStackView() {
        
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 26.0
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        //Constraints
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 250).isActive = true
        //stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        
    }
    func setupAddButton() {
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addButton)
        addButton.addTarget(self, action: #selector(addButtonAction), for: .touchUpInside)
        
        addButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
    }
    
    func addBlur() {
        let blur = BlurEffectView()
        blur.frame = view.bounds
        blur.tag = 100
        
        view.addSubview(blur)
        let blurTap = UITapGestureRecognizer(target: self, action:  #selector (self.handleBlurTap (_:)))
        blur.addGestureRecognizer(blurTap)
        
        view.bringSubviewToFront(addButton)
        view.bringSubviewToFront(locationSearchBar)
        
    }
    
    
    func addSearchBar() {
        
        locationSearchBar.tag = 200
        locationSearchBar.delegate = self
        
        locationSearchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(locationSearchBar)
        locationSearchBar.centerYAnchor.constraint(equalTo: addButton.centerYAnchor).isActive = true
        locationSearchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        locationSearchBar.trailingAnchor.constraint(equalTo: addButton.trailingAnchor, constant: -45).isActive = true
        
    }
    
    
    
    //MARK:- Handle adding and removing searhBar
    func removeSearch() {
        locationSearchBar.text = ""
        removeAfterCancelOrSearch()
        animateButton(bool: !isOn)
    }
    
    func addSearch() {
        animateButton(bool: !isOn)
        addSearchBar()
        addBlur()
        
    }
    
    func removeAfterCancelOrSearch() {
        
        // Remove blur
        if let viewWithTag = self.view.viewWithTag(100) {
            viewWithTag.removeFromSuperview()
        }
        
        // Remove searchBar
        if let viewWithTag = self.view.viewWithTag(200) {
            viewWithTag.removeFromSuperview()
        }
    }
    
    
    
    //MARK:- Actions
    @objc func addButtonAction() {
        
        if isOn == true {
            removeSearch()
            
        }else if isOn == false{
            addSearch()
        }
    }
    
    @objc func handleBlurTap(_ sender: UITapGestureRecognizer){
        removeSearch()
    }
    
    
    
    //MARK:- Animations
    //Animate button
    func animateButton(bool: Bool) {
        isOn = bool
        
        if isOn == true {
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut, animations: {
                self.addButton.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 4))
                self.view.layoutIfNeeded()
            }, completion: nil)
            
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut, animations: {
                self.addButton.plusShapeLayer.strokeColor = UIColor(red:0.86, green:0.20, blue:0.24, alpha:1.0).cgColor
            }, completion: nil)
        }
        
        
        if isOn == false {
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut, animations: {
                self.addButton.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 2))
                self.view.layoutIfNeeded()
            }, completion: nil)
            
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut, animations: {
                self.addButton.plusShapeLayer.strokeColor = UIColor(red:0.35, green:0.71, blue:0.56, alpha:1.0).cgColor
            }, completion: nil)
        }
    }
    
    
    //TODO:- SearchBar animation
    
    //MARK: - SearchBar
    
    
    //    //TODO: - Handle textDidChange: Implement Googles api for suggesting locations
    //    func searchBar(_ searchBar: UISearchBar, textDidChange: String) {
    //
    //
    //    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Ignore user
        UIApplication.shared.beginIgnoringInteractionEvents()
        // Activity Indicator
        // Create cool animation instead
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        
        //TODO: - Hide searchBar
        
        // Create search request
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchBar.text
        
        let activeSearch = MKLocalSearch(request: searchRequest)
        activeSearch.start { (response, error) in
            
            // Stop animation
            activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            
            if response != nil {
                
                // Get latitude and longitude from the location user has entered
                let latitude = response?.mapItems.first?.placemark.coordinate.latitude
                let longitude = response?.mapItems.first?.placemark.coordinate.longitude
                
                self.coordinate.lat = latitude!
                self.coordinate.long = longitude!
                self.searchedLocation = searchBar.text!
                
                // Get weather information needed for the weatherView
                self.getWeather(latitude: latitude!, longitude: longitude!)
                
                
                self.removeSearch()
            }else{
                
                print("Error: No response (activeSearch")
            }
        }
    }
    
    
    
    
    //MARK: - Get weather
    func getWeather(latitude: Double, longitude: Double) {
    
        let currentGroup = DispatchGroup()
        var counter = 0
        var tempString = String()
        var iconString = String()
            
        currentGroup.enter()
        DispatchQueue.global(qos: .background).sync {
            let forecastService = ForecastService(APIKey: Constants.forecastAPIKey)
            
            forecastService.getForecast(latitude: latitude, longitude: longitude) { (currentWeather, hourlyWeather, dailyWeather) in
                
                
                //MARK: Current weather
                if let currentWeatherValues = currentWeather {
                    
                    if let temperature = currentWeatherValues.temperature {
                        let celciusTemperatureDouble = (temperature - 32) * 5 / 9
                        tempString = NSString(format: "%.1f", celciusTemperatureDouble) as String
                    }
                    
                    if let icon = currentWeatherValues.icon {
                        iconString = icon
                    }
                    
                    if tempString != "" && iconString != "" && counter < 1 {
                        currentGroup.leave()

                    }
                    counter = counter + 1
                }
                
            }
        }
        
        currentGroup.notify(queue: .main) {
            self.createWeatherView(temp: tempString, icon: iconString)
        }
    }
    
    
    //MARK: - WeatherView
    func createWeatherView(temp: String, icon: String) {
        
        let simpleWeatherView = SimpleWeatherView()
        
        simpleWeatherView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(simpleWeatherView)
        
        simpleWeatherView.setupTempLabel(temp: temp)
        simpleWeatherView.setupLocLabel(loc: searchedLocation)
        simpleWeatherView.setupIcon(icon: icon)
        
        simpleWeatherView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        simpleWeatherView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        let viewTapRecognizer = UITapGestureRecognizer(target:self,action:#selector(self.onTap))
        viewTapRecognizer.numberOfTapsRequired = 1
        simpleWeatherView.addGestureRecognizer(viewTapRecognizer)
        
        
        
        
    }
    
    
    
    //MARK:- Save location
    func createWeatherData(latitude: Double, longitude: Double) {
        // Fetch the trip with the name of the trip
        let saveAppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = saveAppDelegate.persistentContainer.viewContext
        
        
        let newLocation = NSEntityDescription.insertNewObject(forEntityName: "Location", into: context)
        
        newLocation.setValue(latitude, forKey: "latitude")
        newLocation.setValue(longitude, forKey: "longitude")
        
        do {
            try context.save()
            print("Saved")
            print(context)
        } catch {
            print("Problems")
        }
        
    }
    
    //MARK: Load locations
    //TODO: Build the whole thing so that it loads all the locations from CoreData and creates weatherview for them and fills them with CURRENT weatherdata
    func loadLocations() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Location")
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            
            if results.count > 0 {
                
                for result in results as! [NSManagedObject] {
                    
                    let longitude = result.value(forKey: "longitude") as! CLLocationDegrees
                    let latitude = result.value(forKey: "latitude") as! CLLocationDegrees
                    
                }
            }else{
                print("No locations saved.")
            }
        } catch {
            print("Problems loading stuff")
        }
    }
    
    
    
    //MARK: - OnTap of WeatherView
    @objc func onTap() {
        
        //TODO:- Ugly and unpractical, rework this whole thing. Example pass whole weatherobject instead of all these separately
        let spinViewController = WeekViewController()
        spinViewController.longitude = self.coordinate.long
        spinViewController.latitude = self.coordinate.lat
       
       
        spinViewController.modalPresentationStyle = .fullScreen
        self.present(spinViewController, animated: false, completion: nil)
        
        
    }
}

