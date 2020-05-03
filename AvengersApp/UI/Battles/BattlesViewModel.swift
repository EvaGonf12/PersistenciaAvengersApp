//
//  BattlesViewModel.swift
//  AvengersApp
//
//  Created by Eva Gonzalez Ferreira on 24/04/2020.
//  Copyright © 2020 Eva Gonzalez Ferreira. All rights reserved.
//

import UIKit

protocol BattlesViewDelegate: class {
    func battlesFetched()
    func reloadData()
}

class BattlesViewModel {

    weak var viewDelegate: BattlesViewDelegate?
    let battlesDataManager: BattleDataManager
    let superherosDataManager: SuperherosDataManager
    let villainsDataManager: VillainDataManager
    
    var battlesViewModels: [BattleCellViewModel] = []
    var villains: [Villain] = []
    var superheros: [Superhero] = []

    init(battlesDataManager: BattleDataManager,
         superherosDataManager: SuperherosDataManager,
         villainsDataManager: VillainDataManager) {
        self.battlesDataManager = battlesDataManager
        self.superherosDataManager = superherosDataManager
        self.villainsDataManager = villainsDataManager
    }
    
    fileprivate func fetchBattlesAndReloadUI() {
        self.battlesViewModels = battlesDataManager.fetchAllBattles().map({ BattleCellViewModel(battle: $0) })
        self.viewDelegate?.battlesFetched()
        self.villains = villainsDataManager.fetchAllVillains()
        self.superheros = superherosDataManager.fetchAllSuperHeroes()
    }

    func viewWasLoaded() {
        fetchBattlesAndReloadUI()
    }

    func generateID() -> Int {
        var id = self.battlesViewModels.count
        if self.battlesViewModels.count > 0,
           self.battlesViewModels[id-1].battleID > id + 1 {
            id = self.battlesViewModels[id-1].battleID + 1
        }
        return id
    }

    func numberOfSections() -> Int {
        return 1
    }

    func numberOfRows(in section: Int) -> Int {
        return battlesViewModels.count
    }

    func viewModel(at indexPath: IndexPath) -> BattleCellViewModel? {
        guard indexPath.row < battlesViewModels.count else { return nil }
        return battlesViewModels[indexPath.row]
    }

    func didSelectRow(at indexPath: IndexPath) {
//        guard indexPath.row < battlesViewModels.count else { return }
//        let battle = self.battlesViewModels[indexPath.row]
    }
}

extension BattlesViewModel: BattlesViewModelDelegate {
    func createBattle(name: String, villain: Villain, superhero: Superhero, winner: WinnerEnum) {
        let id = generateID()
        self.battlesDataManager.createBattle(id: id, name: name, villain: villain, superhero: superhero, winner: winner.rawValue)
        self.viewDelegate?.reloadData()
    }
}
