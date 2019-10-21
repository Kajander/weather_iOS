//
//  BackButton.swift
//  Weather
//
//  Created by Joakim Kajan on 08.07.2019.
//  Copyright © 2019 JapeSoft. All rights reserved.
//

import UIKit


class BackButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    func setupButton() {
        drawButton()
    }
    
    
    func drawButton(){
        
        let buttonPath = UIBezierPath()
        let buttonShapeLayer = CAShapeLayer()
        
        let firstPoint = CGPoint(x: frame.origin.x + 20, y: frame.origin.y)
        let secondPoint = CGPoint(x: frame.origin.x + 5, y: frame.origin.y + 15)
        let thirdPoint = CGPoint(x: frame.origin.x + 20, y: frame.origin.y + 30)
        buttonPath.move(to: firstPoint)
        buttonPath.addLine(to: secondPoint)
        buttonPath.addLine(to: thirdPoint)
        
        buttonShapeLayer.path = buttonPath.cgPath
        buttonShapeLayer.lineWidth = 5
        buttonShapeLayer.lineCap = .round
        buttonShapeLayer.lineJoin = .round
        buttonShapeLayer.strokeColor = UIColor.black.cgColor
        buttonShapeLayer.fillColor = UIColor.clear.cgColor
        
        layer.addSublayer(buttonShapeLayer)
    }
}
