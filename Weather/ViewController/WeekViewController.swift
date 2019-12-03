//
//  SpinViewController.swift
//  Weather
//
//  Created by Joakim Kajan on 02.09.2019.
//  Copyright © 2019 JapeSoft. All rights reserved.
//

import UIKit
import MapKit


class WeekViewController: UIViewController {
    
    let sceneView = SceneView()
    let detailView = DetailView()
    let sliderTimeLabel = SliderTimeLabel()
    let tempLabel = TemperatureLabel()
    let summaryLabel = SummaryLabel()
    
    var sunView = UIView()
    var moonView = UIView()
    let contentView = UIView()
    let scrollView = UIScrollView()
    
    var longitude: CLLocationDegrees = 0.0
    var latitude: CLLocationDegrees = 0.0
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getHourlyWeather()
        
        setupBackround()
        setupScrollView()
        
    }
    
    
    
    //MARK: - Setup all the views
    
    func setupScrollView() {
        
        scrollView.isScrollEnabled = true
        scrollView.frame = view.frame
        // If scrollview starts acting up, check this:
        // https://stackoverflow.com/questions/48216808/programmatic-uiscrollview-with-autolayout
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        setupContentView()

    }
    
    func setupBackround() {
        
        let backroundGradient = CAGradientLayer()
        backroundGradient.frame = view.bounds
        var colors = [CGColor]()
        colors.append(UIColor(red:0.08, green:0.60, blue:0.54, alpha:1.0).cgColor)
        colors.append(UIColor(red:0.08, green:0.60, blue:0.54, alpha:1.0).cgColor)
        colors.append(UIColor.white.cgColor)
        colors.append(UIColor.white.cgColor)
        backroundGradient.colors = colors
        backroundGradient.locations = [0.0, 0.4, 0.6, 1.0]
        view.layer.addSublayer(backroundGradient)
    }
    
    
    //MARK: SceneView
    // Scene with mountains and stuff
    func setupSceneView() {
        sceneView.frame = CGRect(x: view.frame.origin.x, y: view.frame.origin.y, width: view.frame.width, height: view.frame.height / 4 * 3)
        sceneView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(sceneView)
        
        sceneView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        sceneView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        sceneView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        sceneView.heightAnchor.constraint(equalToConstant: view.frame.height / 4 * 3).isActive = true
        
        sceneView.clipsToBounds = true
        sceneView.backgroundColor = UIColor(red:0.08, green:0.60, blue:0.54, alpha:1.0)
        
        setupTimeSlider()
        setupTempLabel()
        setupSummaryLabel()
        setupBackButton()
        
        
    }
    
    //MARK: ContentView
    func setupContentView() {
        contentView.frame = scrollView.frame
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.layer.masksToBounds = false
        contentView.backgroundColor = UIColor.darkGray
        
    }
    
    //MARK: DetailView
    func setupDetailView(dailyIconList: [String], dailyMinTemp: [String], dailyMaxTemp: [String]) {
        
        detailView.frame = scrollView.frame
        detailView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(detailView)
        
        let coordinates = CLLocation(latitude: latitude, longitude: longitude)
        
        // Setup the content of the view
        detailView.setupView(location: coordinates, dailyIconList: dailyIconList, dailyMinTemp: dailyMinTemp, dailyMaxTemp: dailyMaxTemp)
        
        detailView.topAnchor.constraint(equalTo: sceneView.bottomAnchor, constant: -50).isActive = true
        detailView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        detailView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        detailView.heightAnchor.constraint(equalToConstant: 600).isActive = true
        detailView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
    }
    
    
    
    //MARK: - Setup and handle slider
    func setupTimeSlider() {

        let timeSlider = TimeSlider()
        timeSlider.tag = 0
        sceneView.addSubview(timeSlider)
        timeSlider.translatesAutoresizingMaskIntoConstraints = false
        timeSlider.leadingAnchor.constraint(equalTo: sceneView.leadingAnchor, constant: 20).isActive = true
        timeSlider.trailingAnchor.constraint(equalTo: sceneView.trailingAnchor, constant: -20).isActive = true
        timeSlider.bottomAnchor.constraint(equalTo: sceneView.bottomAnchor, constant: -60).isActive = true
        
        timeSlider.addTarget(self, action: #selector(WeekViewController.sliderValueChange(_:)), for: .valueChanged)
        setupSliderTimeLabel()
        
    }
    
    @objc func sliderValueChange(_ sender: UISlider) {
        let step: Float = 1
        let currentValue = Int(round((sender.value - sender.minimumValue) / step))
        var forwards: Bool
        
        if currentValue > sender.tag {
            forwards = true
            updateSunPosition(forwards: forwards, multiplier: currentValue)
            updateMoonPosition(forwards: forwards, multiplier: currentValue)
            sender.tag = sender.tag + 1
            
            sliderTimeLabel.updateLabel(i: currentValue)
            tempLabel.updateTempLabel(i: currentValue)
            summaryLabel.updateSummaryLabel(i: currentValue)
        }
        
        if currentValue < sender.tag {
            forwards = false
            updateSunPosition(forwards: forwards, multiplier: currentValue)
            updateMoonPosition(forwards: forwards, multiplier: currentValue)
            sender.tag = currentValue
            
            sliderTimeLabel.updateLabel(i: currentValue)
            tempLabel.updateTempLabel(i: currentValue)
            summaryLabel.updateSummaryLabel(i: currentValue)
            
        }
    }
    
    
    
    //MARK: - Setup and handle WeatherIcons
    func setupSun(sunriseList: [Date], sunsetList: [Date], timeList: [Date]) {
        
        let sunLayer = sceneView.setupSun()
        sunView.layer.addSublayer(sunLayer)
        let defSunLeadingConstant = sceneView.getConstant(sunriseList: sunriseList, sunsetList: sunsetList, timeList: timeList, width: sceneView.frame.width).defaultFirstSunConstant
        sceneView.addSubview(sunView)
        
        sunView.center = CGPoint(x: CGFloat(defSunLeadingConstant), y: sceneView.bounds.height / 5)
        
    }
    
    func updateSunPosition(forwards: Bool, multiplier: Int) {
        //Sliding the slider quickly moves the moons position too much
        //Does it take too long to get the constant value?
        let sunConstant = sceneView.constant

        if forwards == true {
            sunView.center = CGPoint(x: sunView.center.x + CGFloat(sunConstant) , y: sunView.center.y)
        }else{
            sunView.center = CGPoint(x: sunView.center.x - CGFloat(sunConstant) , y: sunView.center.y)
        }
    }
    
    func setupMoon(sunriseList: [Date], sunsetList: [Date], timeList: [Date]) {

        let moonLayer = sceneView.setupMoon()
        moonView.layer.addSublayer(moonLayer)
        let defMoonLeadingConstant = sceneView.getConstant(sunriseList: sunriseList, sunsetList: sunsetList, timeList: timeList, width: sceneView.frame.width).defaultFirstMoonConstant
        sceneView.addSubview(moonView)

        moonView.center = CGPoint(x: CGFloat(defMoonLeadingConstant), y: sceneView.bounds.height / 5)
    }
    
    func updateMoonPosition(forwards: Bool, multiplier: Int) {
        //Sliding the slider quickly moves the moons position too much
        //Does it take too long to get the constant value?
        let moonConstant = sceneView.constant

        if forwards == true {
            moonView.center = CGPoint(x: moonView.center.x + CGFloat(moonConstant) , y: moonView.center.y)
        }else{
            moonView.center = CGPoint(x: moonView.center.x - CGFloat(moonConstant) , y: moonView.center.y)
        }
    }
    
    
    //MARK: - Get weather
    func getHourlyWeather() {
        
        var sunriseList = [Date]()
        var sunsetList = [Date]()
        var hourlyTimeList = [Date]()
        
        var tempList = [String]()
        var summaryList = [String]()
        
        var dailyIconList = [String]()
        var dailyMinTemp = [String]()
        var dailyMaxTemp = [String]()
        
    
        let weatherGroup = DispatchGroup()
        weatherGroup.enter()
        
        // Off the main queue!
        DispatchQueue.global(qos: .background).sync {
            
            let forecastService = ForecastService(APIKey: Constants.forecastAPIKey)
            forecastService.getForecast(latitude: self.latitude, longitude: self.longitude) { (currentWeather, hourlyWeather, dailyWeather) in
                
                
                //MARK: Hourly weather
                if let hourlyWeather = hourlyWeather {
                    
                    if let temperature = hourlyWeather.temperature {
                        if tempList.count < 12 {
                            let celciusTemperatureDouble = (temperature - 32) * 5 / 9
                            let celciusTemperature = NSString(format: "%.0f", celciusTemperatureDouble) as String
                            tempList.append(celciusTemperature)
                        }
                    }
                    
                    if let summary = hourlyWeather.summary {
                        if summaryList.count < 12 {
                            summaryList.append(summary)
                        }
                    }
                    
                    if let time = hourlyWeather.time {
                        let timeDate = Date(timeIntervalSince1970: TimeInterval(time))
                        hourlyTimeList.append(timeDate)
                    }
                }
                
                //MARK: Daily weather
                if let dailyWeather = dailyWeather {
                    
                    if let sunRise = dailyWeather.sunriseTime {
                        let sunriseDate = Date(timeIntervalSince1970: TimeInterval(sunRise))
                        sunriseList.append(sunriseDate)
                        
                    }
                    
                    if let sunSet = dailyWeather.sunsetTime {
                        let sunsetDate = Date(timeIntervalSince1970: TimeInterval(sunSet))
                        sunsetList.append(sunsetDate)
                    }
                    
                    
                    if let icon = dailyWeather.icon {
                        dailyIconList.append(icon)
                    }
                    
                    if let minTemp = dailyWeather.temperatureMin {
                        let minTempDouble = (minTemp - 32) * 5 / 9
                        let minTempString = NSString(format: "%.1f", minTempDouble) as String
                        dailyMinTemp.append(minTempString)
                    }
                    
                    if let maxTemp = dailyWeather.temperatureMax {
                        let maxTempDouble = (maxTemp - 32) * 5 / 9
                        let maxTempString = NSString(format: "%.1f", maxTempDouble) as String
                        dailyMaxTemp.append(maxTempString)
                    }
                }
                
                
                if sunriseList.count == 8 {
                    weatherGroup.leave()
                }
            }
        }
        
        weatherGroup.notify(queue: .main) {
            
            self.setupSceneView()
            self.setupSun(sunriseList: sunriseList, sunsetList: sunsetList, timeList: hourlyTimeList)
            self.setupMoon(sunriseList: sunriseList, sunsetList: sunsetList, timeList: hourlyTimeList)
            
            // when everything is done, put the data where needed
            self.tempLabel.temperatureList = tempList
            self.summaryLabel.summaryList = summaryList
            
            self.tempLabel.updateTempLabel(i: 0)
            self.summaryLabel.updateSummaryLabel(i: 0)
            
            self.setupDetailView(dailyIconList: dailyIconList, dailyMinTemp: dailyMinTemp, dailyMaxTemp: dailyMaxTemp)
            
        }
    }
    
    
    //MARK:-  Setup SceneView content
    
    //MARK: SliderTimeLabel
    func setupSliderTimeLabel() {
        sliderTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        sceneView.addSubview(sliderTimeLabel)
        sliderTimeLabel.centerXAnchor.constraint(equalTo: sceneView.centerXAnchor).isActive = true
        sliderTimeLabel.bottomAnchor.constraint(equalTo: sceneView.bottomAnchor, constant: -95).isActive = true
        sliderTimeLabel.updateLabel(i: 0)
        
    }
    
    //MARK: TemperatureLabel
    func setupTempLabel() {
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        sceneView.addSubview(tempLabel)
        tempLabel.trailingAnchor.constraint(equalTo: sceneView.trailingAnchor, constant: -30).isActive = true
        tempLabel.topAnchor.constraint(equalTo: sceneView.topAnchor, constant: 220).isActive = true
        
    }
    
    //MARK: SummaryLabel
    func setupSummaryLabel() {
        summaryLabel.translatesAutoresizingMaskIntoConstraints = false
        sceneView.addSubview(summaryLabel)
        summaryLabel.trailingAnchor.constraint(equalTo: sceneView.trailingAnchor, constant: -30).isActive = true
        summaryLabel.topAnchor.constraint(equalTo: tempLabel.topAnchor, constant: -20).isActive = true
        
    }
    
    
    
    //MARK: - Setup BackButton
    
    func setupBackButton() {
        
        let backButton = BackButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(backButton)
        backButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 40).isActive = true
        backButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15).isActive = true
        backButton.addTarget(self, action: Selector(("buttonTapped")), for: .touchUpInside)
        
    }
    
    @objc func buttonTapped() {
        
        let mainVC = MainViewController()
        mainVC.modalPresentationStyle = .fullScreen
        self.present(mainVC, animated: false, completion: nil)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}



