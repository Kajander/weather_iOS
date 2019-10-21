//
//  SpinViewController.swift
//  Weather
//
//  Created by Joakim Kajan on 02.09.2019.
//  Copyright © 2019 JapeSoft. All rights reserved.
//

import UIKit
import MapKit


class SpinViewController: UIViewController {
        
    let sceneView = SceneView()
    let detailView = DetailView()
    
    var sunView = UIView()
    var moonView = UIView()
    let contentView = UIView()
    let scrollView = UIScrollView()

    let timeLabel = UILabel()
    let tempLabel = UILabel()
    let summaryLabel = UILabel()
    
    var constant = 0
    var defSunLeadingConstant = 0
    var defMoonLeadingConstant = 0
    
    // Purkkaviri; Korjaa!
    var previousValue = 0
    
    var longitude: CLLocationDegrees = 0.0
    var latitude: CLLocationDegrees = 0.0
    
    // Fix all this stuff
    var sunriseList = [Date]()
    var sunsetList = [Date]()
    var hourlyTimeList = [Date]()
    var dailyTimeList = [Date]()
    var dailyIconList = [String]()
    var dailyMinTemp = [String]()
    var dailyMaxTemp = [String]()
    
    var tempList = [String]()
    var summaryList = [String]()
    var iconList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackround()
        setupScrollView()
        getHourlyWeather()
        setupSceneView()
        setupTimeSlider()
        setupSun()
        setupMoon()
        setupTempLabel()
        setupSummaryLabel()
        setupBackButton()
        
    }
    
    
    
    //MARK: - Setup all the views
    
    func setupScrollView() {
        
        scrollView.isScrollEnabled = true
        scrollView.frame = view.frame
        // If scrollview starts to fuck up, check this:
        // https://stackoverflow.com/questions/48216808/programmatic-uiscrollview-with-autolayout
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
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
        
        setupContentView()
        setupDetailView()
        
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
    func setupDetailView() {
        
        detailView.frame = scrollView.frame
        detailView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(detailView)
        
        let coordinates = CLLocation(latitude: latitude, longitude: longitude)
        
        // Setup the content of the view
        detailView.setupView(location: coordinates, dailyTimeList: dailyTimeList, dailyIconList: dailyIconList, dailyMinTemp: dailyMinTemp, dailyMaxTemp: dailyMaxTemp)
        
        detailView.topAnchor.constraint(equalTo: sceneView.bottomAnchor, constant: -50).isActive = true
        detailView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        detailView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        detailView.heightAnchor.constraint(equalToConstant: 600).isActive = true
        detailView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
                
        
    }
    
    
    
    //MARK: - Setup and handle slider
    func setupTimeSlider() {
        
        let timeSlider = TimeSlider()
        sceneView.addSubview(timeSlider)
        timeSlider.translatesAutoresizingMaskIntoConstraints = false
        timeSlider.leadingAnchor.constraint(equalTo: sceneView.leadingAnchor, constant: 20).isActive = true
        timeSlider.trailingAnchor.constraint(equalTo: sceneView.trailingAnchor, constant: -20).isActive = true
        timeSlider.bottomAnchor.constraint(equalTo: sceneView.bottomAnchor, constant: -60).isActive = true
        
        timeSlider.addTarget(self, action: #selector(SpinViewController.sliderValueChange(_:)), for: .valueChanged)
        
        setupTimeLabel()
        
    }
    
    @objc func sliderValueChange(_ sender: UISlider) {
        let step: Float = 1
        let currentValue = Int(round((sender.value - sender.minimumValue) / step))
        var forwards: Bool
        
        if currentValue > previousValue {
            forwards = true
            updateSunPosition(forwards: forwards, multiplier: currentValue)
            updateMoonPosition(forwards: forwards, multiplier: currentValue)
            previousValue = previousValue + 1
            updateTimeLabel(i: currentValue)
            updateTempLabel(i: currentValue)
            updateSummaryLabel(i: currentValue)
        }
        
        if currentValue < previousValue {
            forwards = false
            updateSunPosition(forwards: forwards, multiplier: currentValue)
            updateMoonPosition(forwards: forwards, multiplier: currentValue)
            previousValue = currentValue
            updateTimeLabel(i: currentValue)
            updateTempLabel(i: currentValue)
            updateSummaryLabel(i: currentValue)
        }
    }
    
    
    
    //MARK: - Setup and handle WeatherIcons
    func setupSun() {
        
        let sunLayer = sceneView.setupSun()
        sunView.layer.addSublayer(sunLayer)
        defSunLeadingConstant = sceneView.getConstant(sunriseList: sunriseList, sunsetList: sunsetList, timeList: hourlyTimeList, width: sceneView.frame.width).defaultFirstSunConstant
        sceneView.addSubview(sunView)
        
        constant = sceneView.getConstant(sunriseList: sunriseList, sunsetList: sunsetList, timeList: hourlyTimeList, width: sceneView.frame.width).constant
        
        sunView.center = CGPoint(x: CGFloat(defSunLeadingConstant), y: sceneView.bounds.height / 5)
        
    }
    
    func updateSunPosition(forwards: Bool, multiplier: Int) {
        if forwards == true {
            sunView.center = CGPoint(x: CGFloat(defSunLeadingConstant) + CGFloat((constant * multiplier)) , y: sunView.center.y)
        }else{
            sunView.center = CGPoint(x: CGFloat(defSunLeadingConstant) - CGFloat((-constant * multiplier)) , y: sunView.center.y)
        }
    }
    
    func setupMoon() {
        // CLEAN THAT DEFFFF
        let moonLayer = sceneView.setupMoon()
        moonView.layer.addSublayer(moonLayer)
        defMoonLeadingConstant = sceneView.getConstant(sunriseList: sunriseList, sunsetList: sunsetList, timeList: hourlyTimeList, width: sceneView.frame.width).defaultFirstMoonConstant
        sceneView.addSubview(moonView)
        moonView.center = CGPoint(x: CGFloat(defMoonLeadingConstant), y: sceneView.bounds.height / 5)
    }
    
    func updateMoonPosition(forwards: Bool, multiplier: Int) {
        if forwards == true {
            moonView.center = CGPoint(x: CGFloat(defMoonLeadingConstant) + CGFloat((constant * multiplier)) , y: moonView.center.y)
        }else{
            moonView.center = CGPoint(x: CGFloat(defMoonLeadingConstant) - CGFloat((-constant * multiplier)) , y: moonView.center.y)
        }
    }
    
    
    //MARK: - Hourly weather
    func getHourlyWeather() {
        
        let hourlyGroup = DispatchGroup()
        hourlyGroup.enter()
        
        // Off the main queue!
        DispatchQueue.global(qos: .background).sync {

            let forecastService = ForecastService(APIKey: Constants.forecastAPIKey)
            forecastService.getForecast(latitude: self.latitude, longitude: self.longitude) { (currentWeather, hourlyWeather, dailyWeather) in
                
                if let hourlyWeather = hourlyWeather {
                    
                    if let temperature = hourlyWeather.temperature {
                        if self.tempList.count < 12 {
                            let celciusTemperatureDouble = (temperature - 32) * 5 / 9
                            let celciusTemperature = NSString(format: "%.0f", celciusTemperatureDouble) as String
                            self.tempList.append(celciusTemperature)
                        }
                    }
                    
                    if let summary = hourlyWeather.summary {
                        if self.summaryList.count < 12 {
                            self.summaryList.append(summary)
                        }
                    }
                    
                    if let icon = hourlyWeather.icon {
                        if self.iconList.count < 12 {
                            self.iconList.append(icon)
                        }
                    }
                }
                if self.iconList.count == 11 {
                    hourlyGroup.leave()
                    
                }
            }
        }
        
        hourlyGroup.notify(queue: .main) {
            // when everything is done, put the data where needed
            self.updateTempLabel(i: 0)
            self.updateSummaryLabel(i: 0)
        }
    }
    
    
    //MARK:-  Setup SceneView content
    
    //MARK: TimeLabel
    func setupTimeLabel() {
        
        timeLabel.font = UIFont.boldSystemFont(ofSize: 16)
        timeLabel.textColor = .white
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        sceneView.addSubview(timeLabel)
        timeLabel.centerXAnchor.constraint(equalTo: sceneView.centerXAnchor).isActive = true
        timeLabel.bottomAnchor.constraint(equalTo: sceneView.bottomAnchor, constant: -95).isActive = true
        updateTimeLabel(i: 0)
        

    }

    func updateTimeLabel(i: Int) {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:00"
        let time = hourlyTimeList[i]
        let StringTime = timeFormatter.string(from: time)
        timeLabel.text = "\(StringTime)"
    }
    
    //MARK: TemperatureLabel
    func setupTempLabel() {
        
        tempLabel.font = UIFont(name: "ArialRoundedMTBold" ,size: 64)
        tempLabel.textColor = .white
        tempLabel.textAlignment = .center
        
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        sceneView.addSubview(tempLabel)
        tempLabel.trailingAnchor.constraint(equalTo: sceneView.trailingAnchor, constant: -30).isActive = true
        tempLabel.topAnchor.constraint(equalTo: sceneView.topAnchor, constant: 220).isActive = true
        
    }

    func updateTempLabel(i: Int) {
        let temp = tempList[i]
        tempLabel.text = "\(temp)°"
    }
    
    //MARK: SummaryLabel
    func setupSummaryLabel() {

        summaryLabel.font = UIFont(name: "ArialRoundedMTBold" ,size: 18)
        summaryLabel.textColor = .white
        summaryLabel.textAlignment = .center
        
        summaryLabel.translatesAutoresizingMaskIntoConstraints = false
        sceneView.addSubview(summaryLabel)
        summaryLabel.trailingAnchor.constraint(equalTo: sceneView.trailingAnchor, constant: -30).isActive = true
        summaryLabel.topAnchor.constraint(equalTo: tempLabel.topAnchor, constant: -20).isActive = true
        
    }
    
    func updateSummaryLabel(i: Int) {
        let summary = summaryList[i]
        summaryLabel.text = summary
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



