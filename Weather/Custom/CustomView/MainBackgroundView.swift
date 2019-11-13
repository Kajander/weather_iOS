//
//  MainBackgroundView.swift
//  Weather
//
//  Created by Joakim Kajan on 12.11.2019.
//  Copyright © 2019 JapeSoft. All rights reserved.
//

import UIKit

class MainBackgroundView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        
    }

    override func draw(_ rect: CGRect) {
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: bounds.minX, y: bounds.minY))
        path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.minY))
        path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.minY + bounds.height / 4))
        path.addLine(to: CGPoint(x: bounds.maxX / 4, y: bounds.minY + bounds.height / 4))
        path.addQuadCurve(to: CGPoint(x: bounds.minX, y: bounds.minY + bounds.height / 4 + bounds.width / 4), controlPoint: CGPoint(x: bounds.minX, y: bounds.minY + bounds.height / 4))
        path.close()
        UIColor(red:0.33, green:0.70, blue:1.00, alpha:1.0).setFill()
        path.fill()
        
    }
    
}
