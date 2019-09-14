//
//  Gradinet.swift
//  TestairWeatherApp
//
//  Created by Macovei, Ionut on 14/09/2019.
//  Copyright © 2019 Macovei, Ionut. All rights reserved.
//

import UIKit
import ChameleonFramework

let colors: [UIColor] = [UIColor.flatGreenDark,
                         UIColor.flatLime]

extension UIColor {
    func applyGradient(for view: UIView) {
        view.backgroundColor = GradientColor(.topToBottom,
                                             frame: view.frame,
                                             colors: colors)
    }
}

