//
//  ListWeatherViewController.swift
//  TestairWeatherApp
//
//  Created by Macovei, Ionut on 14/09/2019.
//  Copyright © 2019 Macovei, Ionut. All rights reserved.
//

import UIKit

protocol ListWeatherView: class {
    func redraw()
}

class ListWeatherViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    var presenter: ListWeatherPresenter!
    
    static func initialize(with presenter: ListWeatherPresenter) -> ListWeatherViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "weatherTableVC") as! ListWeatherViewController
        vc.presenter = presenter
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupTableView()
        presenter.setView(self)
        // Do any additional setup after loading the view.
    }
    
    private func setup() {
        view.backgroundColor?.applyGradient(for: view)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.rowHeight = 190
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: WeatherTableViewCell.nib, bundle: nil), forCellReuseIdentifier: WeatherTableViewCell.reuseIdentifier)
    }
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension ListWeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.reuseIdentifier, for: indexPath) as? WeatherTableViewCell else {
            return UITableViewCell()
        }
        presenter.configure(cell: cell, row: indexPath.row)
        return cell
    }
}

extension ListWeatherViewController: ListWeatherView {
    func redraw() {
        tableView.reloadData()
    }
}
