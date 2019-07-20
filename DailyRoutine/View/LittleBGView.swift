//
//  LittleBGView.swift
//  DailyRoutine
//
//  Created by Matheus Marcos Maus on 05/07/19.
//  Copyright © 2019 Matheus Marcos Maus. All rights reserved.
//

import Foundation
import UIKit

class LittleBGView: UIView {
    override open class var layerClass: AnyClass {
        return CAGradientLayer.classForCoder()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let gradientLayer = layer as! CAGradientLayer
        gradientLayer.colors = [UIColor(red: 143.0/255.0, green: 148.0/255.0, blue: 251.0/255.0, alpha: 1.0).cgColor,
                                UIColor(red: 78.0/255.0, green: 84.0/255.0, blue: 200.0/255.0, alpha: 1.0).cgColor]
        gradientLayer.locations = [0.0, 1.0]
    }
}
