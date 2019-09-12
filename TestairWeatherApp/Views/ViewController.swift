//
//  ViewController.swift
//  TestairWeatherApp
//
//  Created by Macovei, Ionut on 12/09/2019.
//  Copyright © 2019 Macovei, Ionut. All rights reserved.
//

import UIKit
import ChameleonFramework

let colors: [UIColor] = [UIColor.flatGreenDark,
                         UIColor.flatLime]

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = GradientColor(.topToBottom, frame: view.frame, colors: colors)

    }


}

