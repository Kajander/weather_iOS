//
//  BlurEffectView.swift
//  Weather
//
//  Created by Joakim Kajan on 04.10.2019.
//  Copyright © 2019 JapeSoft. All rights reserved.
//

import UIKit

class BlurEffectView: UIVisualEffectView {

 
   override init(effect: UIVisualEffect?) {
        super.init(effect: effect)
        setupBlurView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupBlurView()
    }
    
    
    func setupBlurView() {
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
        self.effect = blurEffect
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]

    }
}
