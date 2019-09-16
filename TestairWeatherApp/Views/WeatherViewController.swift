//
//  WeatherViewController.swift
//  TestairWeatherApp
//
//  Created by Macovei, Ionut on 12/09/2019.
//  Copyright © 2019 Macovei, Ionut. All rights reserved.
//

import UIKit

protocol WeatherView: class {
    func moveTo(nextPresenter: ListWeatherPresenter)
}

class WeatherViewController: UIViewController {
    @IBOutlet var textField: UITextField!
    
    private var presenter = WeatherPresenter()
    
    internal var btnDropDown: UIButton {
        let size: CGFloat = 25.0
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "right_arrow"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -(size/2.0), bottom: 0, right: 6)
        button.frame = CGRect(x: textField.frame.size.width - size, y: 0.0, width: size, height: size)
        button.addTarget(self, action: #selector(requestWeather), for: .touchUpInside)
        
        return button
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupTextfield()
        presenter.setView(self)
    }
    
    private func setup() {
        let _ = view.backgroundColor?.applyGradient(for: view)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func setupTextfield() {
        //         UITextField backgroundColor can't be white because of the image color.
        textField.delegate = self
        textField.rightView = btnDropDown
        textField.rightViewMode = .always
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.white.withAlphaComponent(0.6).cgColor
        textField.clipsToBounds = true
        textField.attributedPlaceholder = NSAttributedString(string: "Enter city name".uppercased(),
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
    }
    @IBAction func viewHistoryAction(_ sender: Any) {
        presenter.showDetails()
    }
    
    @objc func requestWeather() {
        guard let text = textField.text else { return }
        presenter.loadWeatherFor(city: text, completion: { completion in
            if completion {
                self.presenter.showDetails()
            }
            //TODO: Inform user that city provided doesn't exist
        })
    }
}

extension WeatherViewController: WeatherView {
    func moveTo(nextPresenter: ListWeatherPresenter) {
        let vc = ListWeatherViewController.initialize(with: nextPresenter)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension WeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
