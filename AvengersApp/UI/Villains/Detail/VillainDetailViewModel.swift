//
//  VillainDetailViewModel.swift
//  AvengersApp
//
//  Created by Eva Gonzalez Ferreira on 25/04/2020.
//  Copyright © 2020 Eva Gonzalez Ferreira. All rights reserved.
//

import Foundation

protocol VillainDetailViewDelegate: class {
    func villainDetailFetched()
    func reloadData()
}

class VillainDetailViewModel {
    
    // Delegate Villaines list
    weak var listViewDelegate: VillainsViewDelegate?
    weak var detailViewDelegate: VillainDetailViewDelegate?

    let villainDetailDataManager: VillainDetailDataManager

    let villainID: Int
    var villainImage: String?
    var villainName: String?
    var villainPower: Int?
    var villainPowerImg: String?
    var villainDescription: String?
    var villainBattles: [String]?
    

    init(villainID: Int, villainDetailDataManager: VillainDetailDataManager) {
        self.villainID = villainID
        self.villainDetailDataManager = villainDetailDataManager
    }
    
    func fetchVillainAndReloadUI() {
        guard let villain = self.villainDetailDataManager.fetchVillain(byID: self.villainID) else {return}
        self.villainImage = villain.image
        self.villainName = villain.name
        self.villainPower = Int(villain.power)
        self.villainPowerImg = "ic_stars_\(villain.power)"
        self.villainDescription = villain.villainDescription
        self.villainBattles = ["Batalla 1", "Batalla 2", "Batalla 3", "Batalla 4", "Batalla 5"]
        self.detailViewDelegate?.villainDetailFetched()
    }
    
    func viewWasLoaded() {
        self.fetchVillainAndReloadUI()
    }
    
    func changePower(newPower: Int) {
        self.villainPower = newPower
        self.villainPowerImg = "ic_stars_\(newPower)"
        self.villainDetailDataManager.changePowerVillain(newPower, withID: self.villainID, completion: { result in
            if result {
                self.detailViewDelegate?.reloadData()
            }
        })
    }
    
    func backButtonTapped() {
        self.listViewDelegate?.reloadData()
    }
    
}

