//
//  TimeSlider.swift
//  Weather
//
//  Created by Joakim Kajan on 10.09.2019.
//  Copyright © 2019 JapeSoft. All rights reserved.
//

import UIKit

class TimeSlider: UISlider {
    
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSlider()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSlider()
    }
    
    
    func setupSlider() {
        let path = UIBezierPath()
        let thumbSize = CGSize(width: 50, height: 50)
        
        frame = CGRect(x: 0, y: 0, width: 80, height: 10)
        
        maximumTrackTintColor = UIColor(red:0.33, green:0.02, blue:0.15, alpha:1.0)
        minimumTrackTintColor = UIColor(red:0.61, green:0.04, blue:0.27, alpha:1.0)
        
        setThumbImage(image(with: path, size: thumbSize), for: .normal)
        setThumbImage(image(with: path, size: thumbSize), for: .selected)

        
        maximumValue = 12
        minimumValue = 1
        setValue(1, animated: false)
        
    }
    
    
    //MARK: TrackRect
    //Make slider larger
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        var newBounds = super.trackRect(forBounds: bounds)
        newBounds.size.height = 10
    
        return newBounds
    }
    
    //MARK: ThumbImage
    //Set custom drawing as slider thumbImage
    private func image(with path: UIBezierPath, size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            
            path.addArc(withCenter: CGPoint(x: size.width / 2, y: size.height / 2), radius: 15, startAngle: CGFloat(0), endAngle: CGFloat.pi * 2, clockwise: true)
            
            path.move(to: CGPoint(x: size.width / 2, y: size.height / 2))
            path.addLine(to: CGPoint(x: size.width / 2, y: size.height / 2 - 10))
            
            path.move(to: CGPoint(x: size.width / 2, y: size.height / 2))
            path.addLine(to: CGPoint(x: size.width / 2 + 6, y: size.height / 2 + 6))

            path.lineWidth = 4
            path.lineCapStyle = .round
            path.lineJoinStyle = .round
            
            UIColor.white.set()
            path.fill()
            
            UIColor.black.set()
            path.stroke()
            
        }
    }
}


