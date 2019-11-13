//
//  AddButton.swift
//  Weather
//
//  Created by Joakim Kajan on 02.10.2019.
//  Copyright © 2019 JapeSoft. All rights reserved.
//

import UIKit

class AddButton: UIButton {
    
    var width: CGFloat
    var height: CGFloat
    let roundedRectLayer: CAShapeLayer
    let plusShapeLayer: CAShapeLayer


    
    override init(frame: CGRect) {
        width = 40
        height = 40
        roundedRectLayer = CAShapeLayer()
        plusShapeLayer = CAShapeLayer()

        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupButton() {
        backgroundColor = .clear
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 3
    }
    
    override func draw(_ rect: CGRect) {

        #warning("rect is w:30 h:34. Figure out whats wrong")
        let newRect = CGRect(x: 0, y: 0, width: width, height: height)
        
        let buttonPath = UIBezierPath()
        
        let firstPoint = CGPoint(x: newRect.width / 5 * 1, y: newRect.height / 2)
        let secondPoint = CGPoint(x: newRect.width / 5 * 4 , y: newRect.height / 2)
        let thirdPoint = CGPoint(x: newRect.width / 2, y: newRect.height / 5 * 1)
        let fourthPoint = CGPoint(x: newRect.width / 2, y: newRect.height / 5 * 4)
        buttonPath.move(to: firstPoint)
        buttonPath.addLine(to: secondPoint)
        buttonPath.move(to: thirdPoint)
        buttonPath.addLine(to: fourthPoint)
        
        plusShapeLayer.path = buttonPath.cgPath
        plusShapeLayer.lineWidth = 4
        plusShapeLayer.lineCap = .round
        plusShapeLayer.lineJoin = .round
        plusShapeLayer.strokeColor = UIColor(red:0.35, green:0.71, blue:0.56, alpha:1.0).cgColor
        plusShapeLayer.fillColor = UIColor.clear.cgColor
        
        let roundedRectPath = UIBezierPath(roundedRect: newRect, cornerRadius: 5)
        
        roundedRectLayer.path = roundedRectPath.cgPath
        roundedRectLayer.fillColor = UIColor.white.cgColor
        
        layer.addSublayer(roundedRectLayer)
        layer.addSublayer(plusShapeLayer)
    }
    
    
    
    
}
