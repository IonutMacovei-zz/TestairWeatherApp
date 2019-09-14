//
//  WeatherTableViewController.swift
//  TestairWeatherApp
//
//  Created by Macovei, Ionut on 14/09/2019.
//  Copyright © 2019 Macovei, Ionut. All rights reserved.
//

import UIKit

class WeatherTableViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    private var presenter: WeatherPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        view.backgroundColor?.applyGradient(for: view)
        setupTableView()
        presenter = WeatherPresenter()
//        print(presenter.model!)
        // Do any additional setup after loading the view.
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.rowHeight = 200
        
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: WeatherTableViewCell.nib, bundle: nil), forCellReuseIdentifier: WeatherTableViewCell.reuseIdentifier)
    }

}

extension WeatherTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.reuseIdentifier, for: indexPath) as? WeatherTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
    
    
}
