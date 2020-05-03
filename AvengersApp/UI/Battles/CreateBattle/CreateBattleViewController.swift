//
//  CreateBattleViewController.swift
//  AvengersApp
//
//  Created by Eva Gonzalez Ferreira on 02/05/2020.
//  Copyright © 2020 Eva Gonzalez Ferreira. All rights reserved.
//

import UIKit
import PopupDialog

class CreateBattleViewController: UIViewController {

    @IBOutlet weak var selectSuperheroButon: UIButton!
    @IBOutlet weak var selectVillainButton: UIButton!
    @IBOutlet weak var battleName: UITextField!
    @IBOutlet weak var createBattleButton: UIButton!
    @IBOutlet weak var iconBattleReady: UIImageView!

    var delegate: BattlesViewDelegate?
    
    var viewModel: CreateBattleViewModel? {
        didSet {
            self.viewDidLoad()
        }
    }
        
    convenience init(viewModel: CreateBattleViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        title = "Crear Batalla"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                                                   NSAttributedString.Key.font: UIFont.systemFont(ofSize: 21, weight: .semibold)]
        navigationController?.navigationBar.barTintColor = UIColor.init(named: Colors.BlueNavBar.rawValue)
        
        let leftBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeView))
        leftBarButtonItem.tintColor = .white
        navigationItem.leftBarButtonItem = leftBarButtonItem
        
        self.selectSuperheroButon.layer.cornerRadius = 16
        self.selectVillainButton.layer.cornerRadius = 16
        self.createBattleButton.layer.cornerRadius = 8
        
        guard let viewModel = self.viewModel else { return }
        if let superhero = viewModel.superheroSelected {
            selectSuperheroButon.setImage(UIImage(named: superhero.image ?? "addSuperhero"), for: .normal)
        }
        
        if let villain = viewModel.villainSelected {
            selectVillainButton.setImage(UIImage(named: villain.image ?? "addVillain"), for: .normal)
        }
        
        self.iconBattleReady.isHidden = !(viewModel.isVillainSelected() && viewModel.isSuperheroSelected())
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        self.battleName.resignFirstResponder()
    }
    
    @IBAction func selectSuperheroTapped(_ sender: Any) {
        guard let superheros = self.viewModel?.superherosViewModels else { return }
        let superherosVM = ListCompetitorViewModel(superheros: superheros)
        let competitorListVC = ListCompetitorViewController(viewModel: superherosVM)
        superherosVM.listCompetitorViewDelegate = competitorListVC
        superherosVM.createBattleDelegate = self
        let competitorListNav = UINavigationController(rootViewController: competitorListVC)
        self.present(competitorListNav, animated: true, completion: nil)
    }
        
    @IBAction func selectVillainTapped(_ sender: Any) {
        guard let villains = self.viewModel?.villainsViewModels else { return }
        let villainsVM = ListCompetitorViewModel(villains: villains)
        let competitorListVC = ListCompetitorViewController(viewModel: villainsVM)
        villainsVM.createBattleDelegate = self
        villainsVM.listCompetitorViewDelegate = competitorListVC
        let competitorListNav = UINavigationController(rootViewController: competitorListVC)
        self.present(competitorListNav, animated: true, completion: nil)
    }
    
    @IBAction func createBattleButtonTapped(_ sender: Any) {
        self.viewModel?.name = battleName.text
        self.viewModel?.createBattle()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nameChanged(_ sender: Any) {
        self.viewModel?.name = battleName.text
    }
    
    @objc func closeView() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension CreateBattleViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ sender: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

extension CreateBattleViewController: CreateBattleViewDelegate {
    
    func competitorSelected(type: CompetitorType, _ id: Int) {
        self.viewModel?.competitorSelected(type: type, id)
    }
    
    func reloadData() {
        self.viewDidLoad()
    }
}
