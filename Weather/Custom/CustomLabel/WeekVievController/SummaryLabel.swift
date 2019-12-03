//
//  SummaryLabel.swift
//  Weather
//
//  Created by Joakim Kajan on 03.12.2019.
//  Copyright © 2019 JapeSoft. All rights reserved.
//

import UIKit

class SummaryLabel: UILabel {
    
    var summaryList = [String]()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLabel()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }

    func setupLabel() {

        font = UIFont(name: "ArialRoundedMTBold" ,size: 18)
        textColor = .white
        textAlignment = .center
    
    }
    
    func updateSummaryLabel(i: Int) {
        let summary = summaryList[i]
        text = summary
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
