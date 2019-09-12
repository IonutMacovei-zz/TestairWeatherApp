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
    @IBOutlet var textField: UITextField!
    
    private var presenter: WeatherPresenter!
    
    internal var btnDropDown: UIButton {
        let size: CGFloat = 25.0
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "right_arrow"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -(size/2.0), bottom: 0, right: 0)
        button.frame = CGRect(x: textField.frame.size.width - size, y: 0.0, width: size, height: size)
        button.addTarget(self, action: #selector(requestWeather), for: .touchUpInside)
        
        return button
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.rightView = btnDropDown
        textField.rightViewMode = .always
        presenter = WeatherPresenter()
        
        view.backgroundColor = GradientColor(.topToBottom, frame: view.frame, colors: colors)

    }
    
    @objc func requestWeather() {
        guard let text = textField.text else { return }
        presenter.loadWeatherFor(city: text)
    }

}
//extension ViewController: WeatherPresenterProtocol {
//    func showWeather(data: WeatherModel) {
//        <#code#>
//    }
//
//
//}
