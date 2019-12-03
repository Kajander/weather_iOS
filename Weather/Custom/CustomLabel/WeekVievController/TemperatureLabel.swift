//
//  TemperatureLabel.swift
//  Weather
//
//  Created by Joakim Kajan on 03.12.2019.
//  Copyright © 2019 JapeSoft. All rights reserved.
//

import UIKit

class TemperatureLabel: UILabel {

    var temperatureList = [String]()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLabel()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }

    func setupLabel() {

        font = UIFont(name: "ArialRoundedMTBold" ,size: 64)
        textColor = .white
        textAlignment = .center

    }
    
    func updateTempLabel(i: Int) {
        let temp = temperatureList[i]
        text = "\(temp)°"
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
