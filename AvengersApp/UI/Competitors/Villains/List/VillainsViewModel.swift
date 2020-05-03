//
//  VillainsViewModel.swift
//  AvengersApp
//
//  Created by Eva Gonzalez Ferreira on 24/04/2020.
//  Copyright © 2020 Eva Gonzalez Ferreira. All rights reserved.
//

import UIKit

protocol VillainsViewDelegate: class {
    func villainsFetched()
    func changeToDetail(detailViewModel: VillainDetailViewModel)
    func reloadData()
}

class VillainsViewModel {

    weak var viewDelegate: VillainsViewDelegate?
    let villainsDataManager: VillainDataManager
    let villainDetailDataManager : VillainDetailDataManager
    var villainsViewModels: [VillainCellViewModel] = []

    init(villainsDataManager: VillainDataManager,
         villainDetailDataManager: VillainDetailDataManager) {
        self.villainsDataManager = villainsDataManager
        self.villainDetailDataManager = villainDetailDataManager
    }
    
    fileprivate func fetchVillainsAndReloadUI() {
        self.villainsViewModels = villainsDataManager.fetchAllVillains().map({ VillainCellViewModel(villain: $0) })
        self.viewDelegate?.villainsFetched()
    }

    func viewWasLoaded() {
        fetchVillainsAndReloadUI()
    }

    func numberOfSections() -> Int {
        return 1
    }

    func numberOfRows(in section: Int) -> Int {
        return villainsViewModels.count
    }

    func viewModel(at indexPath: IndexPath) -> VillainCellViewModel? {
        guard indexPath.row < villainsViewModels.count else { return nil }
        return villainsViewModels[indexPath.row]
    }

    func didSelectRow(at indexPath: IndexPath) {
        guard indexPath.row < villainsViewModels.count else { return }
        let villain = self.villainsViewModels[indexPath.row]
        let villainDetailDataManager = VillainDetailViewModel(villainID: villain.villainID,
                                                              villainDetailDataManager: self.villainDetailDataManager)
        self.viewDelegate?.changeToDetail(detailViewModel: villainDetailDataManager)
    }
}
