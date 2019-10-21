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
    
    var coordinate: (lat: Double, long: Double) = (0.0,0.0)
    var long: Double = 0.0
    var lat: Double = 0.0
    
    var hourlyWeatherData = [String: Any]()
    var sunriseList = [Date]()
    var sunsetList = [Date]()
    var hourlyTimeList = [Date]()
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
        setupAddButton()

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //loadLocations()
    }
    
    
    
    //MARK: - Setup view
    
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
        //view.bringSubviewToFront(searhBarView)
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
            UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseInOut, animations: {
                self.addButton.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 4))
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
        
        if isOn == false {
            UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseInOut, animations: {
                self.addButton.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 2))
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    
    //TODO:- SearchBar animation
    
    //MARK: - SearchBar
    
    
    //    //TODO: - Handle textDidChange
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
                        print("temppistringgi",tempString)
                    }
                    
                    if let icon = currentWeatherValues.icon {
                        iconString = icon
                        print("iconiii",iconString)
                    }
                    
                    if tempString != "" && iconString != "" && counter < 1 {
                        currentGroup.leave()

                    }
                    counter = counter + 1
                }
                
                
                //MARK: Hourly weather
            
                if let hourlyWeather = hourlyWeather {

                    if let time = hourlyWeather.time {
                        let timeDate = Date(timeIntervalSince1970: TimeInterval(time))
                        self.hourlyTimeList.append(timeDate)
                    }
                }
                
                
                //MARK: Daily weather
                if let dailyWeather = dailyWeather {
                  
                    if let sunRise = dailyWeather.sunriseTime {
                        let sunriseDate = Date(timeIntervalSince1970: TimeInterval(sunRise))
                        self.sunriseList.append(sunriseDate)
                        
                    }
                    
                    if let sunSet = dailyWeather.sunsetTime {
                        let sunsetDate = Date(timeIntervalSince1970: TimeInterval(sunSet))
                        self.sunsetList.append(sunsetDate)
                    }
                    
                    if let time = dailyWeather.time {
                        let timeDate = Date(timeIntervalSince1970: TimeInterval(time))
                        self.dailyTimeList.append(timeDate)
                    }
                    
                    if let icon = dailyWeather.icon {
                        self.dailyIconList.append(icon)
                    }
                    
                    if let minTemp = dailyWeather.temperatureMin {
                        let minTempDouble = (minTemp - 32) * 5 / 9
                        let minTempString = NSString(format: "%.1f", minTempDouble) as String
                        self.dailyMinTemp.append(minTempString)
                    }
                    
                    if let maxTemp = dailyWeather.temperatureMax {
                        let maxTempDouble = (maxTemp - 32) * 5 / 9
                        let maxTempString = NSString(format: "%.1f", maxTempDouble) as String
                        self.dailyMaxTemp.append(maxTempString)
                    }
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
        
        simpleWeatherView.layer.borderColor = UIColor.black.cgColor
        simpleWeatherView.layer.borderWidth = 2
        simpleWeatherView.layer.cornerRadius = 10
        
        // UICOllectionview seteiks tais mennä? tää https://www.raywenderlich.com/9334-uicollectionview-tutorial-getting-started
        simpleWeatherView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(simpleWeatherView)
        
        simpleWeatherView.setupTempLabel(temp: temp)
        simpleWeatherView.setupLocLabel(loc: searchedLocation)
        simpleWeatherView.setupIcon(icon: icon)
        
        simpleWeatherView.topAnchor.constraint(equalTo: view.topAnchor, constant: 250).isActive = true
        simpleWeatherView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        simpleWeatherView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        simpleWeatherView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        let viewTapRecognizer = UITapGestureRecognizer(target:self,action:#selector(self.onTap))
        viewTapRecognizer.numberOfTapsRequired = 1;
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
        
        
        let spinViewController = SpinViewController()
        spinViewController.longitude = self.coordinate.long
        spinViewController.latitude = self.coordinate.lat
        spinViewController.sunriseList = sunriseList
        spinViewController.sunsetList = sunsetList
        spinViewController.hourlyTimeList = hourlyTimeList
        spinViewController.dailyTimeList = dailyTimeList
        spinViewController.dailyIconList = dailyIconList
        spinViewController.dailyMinTemp = dailyMinTemp
        spinViewController.dailyMaxTemp = dailyMaxTemp
        spinViewController.modalPresentationStyle = .fullScreen
        self.present(spinViewController, animated: false, completion: nil)
        
        
    }
}

