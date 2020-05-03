//
//  BattlesViewController.swift
//  AvengersApp
//
//  Created by Eva Gonzalez Ferreira on 24/04/2020.
//  Copyright © 2020 Eva Gonzalez Ferreira. All rights reserved.
//

import UIKit

class BattlesViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.register(UINib(nibName: "BattleTableViewCell", bundle: nil), forCellReuseIdentifier: "BattleTableViewCell")
        table.estimatedRowHeight = 230
        table.rowHeight = UITableView.automaticDimension
        table.separatorStyle = .none
        return table
    }()
    
    var viewModel: BattlesViewModel
    
    init(viewModel: BattlesViewModel) {
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
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        title = "Batallas"
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
        
        let rightBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.app"), style: .plain, target: self, action: #selector(addBattleButtonTapped))
        rightBarButtonItem.tintColor = .white
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewWasLoaded()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.viewWasLoaded()
    }
    
    @objc func addBattleButtonTapped() {
        let createBattleVM = CreateBattleViewModel(superherosViewModels: self.viewModel.superheros,
                                                   villainsViewModels: self.viewModel.villains)
        let createBattleVC = CreateBattleViewController(viewModel: createBattleVM)
        createBattleVM.battlesViewDelegate = self.viewModel
        createBattleVM.createBattleViewDelegate = createBattleVC
        let createBattleNavVC = UINavigationController(rootViewController: createBattleVC)
        createBattleNavVC.modalPresentationStyle = .fullScreen
        present(createBattleNavVC, animated: true, completion: nil)
    }
    
}


extension BattlesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "BattleTableViewCell", for: indexPath) as? BattleTableViewCell,
            let cellViewModel = viewModel.viewModel(at: indexPath) {
            cell.viewModel = cellViewModel
            return cell
        }
        fatalError()
    }
}

extension BattlesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let battle = self.viewModel.battlesViewModels[indexPath.row]
        let deleteAction = UIContextualAction(style: .normal, title: "Eliminar") {[weak self] (action, view, handler) in
            self?.viewModel.deleteBattle(battle)
            handler(true)
        }
        deleteAction.image = UIImage.init(systemName: "trash")
        deleteAction.image?.withTintColor(UIColor.white)
        deleteAction.backgroundColor = UIColor(named: Colors.Red.rawValue)
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])

        return configuration
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectRow(at: indexPath)
    }
}

extension BattlesViewController: BattlesViewDelegate {
    
    func battlesFetched() {
        self.tableView.reloadData()
    }
    
    func reloadData() {
        self.viewDidLoad()
    }
}

