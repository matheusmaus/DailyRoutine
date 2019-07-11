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
        gradientLayer.colors = [UIColor(red: 255.0/255.0, green: 149.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor,
                                UIColor(red: 255.0/255.0, green: 94.0/255.0, blue: 58.0/255.0, alpha: 1.0).cgColor]
        gradientLayer.locations = [0.0, 1.0]
    }
}

