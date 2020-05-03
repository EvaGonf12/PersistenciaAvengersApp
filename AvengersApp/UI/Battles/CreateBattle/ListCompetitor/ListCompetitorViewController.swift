//
//  ListCompetitorViewController.swift
//  AvengersApp
//
//  Created by Eva Gonzalez Ferreira on 02/05/2020.
//  Copyright © 2020 Eva Gonzalez Ferreira. All rights reserved.
//

import UIKit
//CompetitorTableViewCell

class ListCompetitorViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.register(UINib(nibName: "CompetitorTableViewCell", bundle: nil), forCellReuseIdentifier: "CompetitorTableViewCell")
        table.estimatedRowHeight = 90
        table.rowHeight = UITableView.automaticDimension
        table.separatorStyle = .none
        return table
    }()
    
    var viewModel: ListCompetitorViewModel
    
    init(viewModel: ListCompetitorViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = UIView()

        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        title = "Elige un competidor"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                                                   NSAttributedString.Key.font: UIFont.systemFont(ofSize: 21, weight: .semibold)]
        navigationController?.navigationBar.barTintColor = UIColor.init(named: Colors.BlueNavBar.rawValue)
        tabBarController?.tabBar.items?.first?.title = nil
        if let items = tabBarController?.tabBar.items {
            for item in items {
                item.title = ""
                item.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ListCompetitorViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CompetitorTableViewCell", for: indexPath) as? CompetitorTableViewCell,
            let cellViewModel = viewModel.viewModel(at: indexPath) {
                cell.viewModel = cellViewModel
                return cell
        }
        fatalError()
    }
}

extension ListCompetitorViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectRow(at: indexPath)
    }
}

extension ListCompetitorViewController: ListCompetitorViewDelegate {
    func competitorsFetched() {
        self.tableView.reloadData()
    }
    
    func reloadData() {
        self.viewDidLoad()
    }
    
    func closeView() {
        self.dismiss(animated: true, completion: nil)
    }
}
