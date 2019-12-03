//
//  SliderTimeLabel.swift
//  Weather
//
//  Created by Joakim Kajan on 03.12.2019.
//  Copyright © 2019 JapeSoft. All rights reserved.
//

import UIKit

class SliderTimeLabel: UILabel {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLabel()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }

    func setupLabel() {

        font = UIFont.boldSystemFont(ofSize: 16)
        textColor = .white

    }
    
    func updateLabel(i: Int) {
        let now = Date()
        let hour = Calendar.current.date(byAdding: .hour, value: i, to: now) ?? now
        let displayedHour = Calendar.current.component(.hour, from: hour)
        text = "\(displayedHour):00"
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
