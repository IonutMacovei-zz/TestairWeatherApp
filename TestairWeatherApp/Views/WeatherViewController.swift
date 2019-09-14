//
//  WeatherViewController.swift
//  TestairWeatherApp
//
//  Created by Macovei, Ionut on 12/09/2019.
//  Copyright © 2019 Macovei, Ionut. All rights reserved.
//

import UIKit

protocol WeatherView: class {
    func showDetails(nextPresenter: ListWeatherPresenter)
}

class WeatherViewController: UIViewController {
    @IBOutlet var textField: UITextField!
    
    private var presenter = WeatherPresenter()
    
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
        let _ = view.backgroundColor?.applyGradient(for: view)
        navigationController?.setNavigationBarHidden(true, animated: true)
        textField.rightView = btnDropDown
        textField.rightViewMode = .always
        presenter.setView(self)
    }

    @objc func requestWeather() {
        guard let text = textField.text else { return }
        presenter.loadWeatherFor(city: text, completion: { _ in
            self.presenter.showDetails()
        })
    }
}

extension WeatherViewController: WeatherView {
    func showDetails(nextPresenter: ListWeatherPresenter) {
        let vc = ListWeatherViewController.initialize(with: nextPresenter)
        navigationController?.pushViewController(vc, animated: true)
    }
}