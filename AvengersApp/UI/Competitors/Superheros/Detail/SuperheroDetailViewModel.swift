//
//  SuperherosDetailViewModel.swift
//  AvengersApp
//
//  Created by Eva Gonzalez Ferreira on 25/04/2020.
//  Copyright © 2020 Eva Gonzalez Ferreira. All rights reserved.
//

import Foundation

protocol SuperheroDetailViewDelegate: class {
    func superheroDetailFetched()
    func reloadData()
}

class SuperheroDetailViewModel {
    
    // Delegate Superheroes list
    weak var listViewDelegate: SuperheroesViewDelegate?
    weak var detailViewDelegate: SuperheroDetailViewDelegate?

    let superheroDetailDataManager: SuperheroDetailDataManager

    let superheroID: Int
    var superheroImage: String?
    var superheroName: String?
    var superheroPower: Int?
    var superheroPowerImg: String?
    var superheroDescription: String?
    var superheroBattles: [Battle]?
    

    init(superheroID: Int, superheroDetailDataManager: SuperheroDetailDataManager) {
        self.superheroID = superheroID
        self.superheroDetailDataManager = superheroDetailDataManager
    }
    
    func fetchSuperHeroAndReloadUI() {
        guard let (superhero, battles) = self.superheroDetailDataManager.fetchSuperhero(byID: self.superheroID) else {return}
        self.superheroImage = superhero.image
        self.superheroName = superhero.name
        self.superheroPower = Int(superhero.power)
        self.superheroPowerImg = "ic_stars_\(superhero.power)"
        self.superheroDescription = superhero.superheroDescription
        self.superheroBattles = battles
        self.detailViewDelegate?.superheroDetailFetched()
    }
    
    func viewWasLoaded() {
        self.fetchSuperHeroAndReloadUI()
    }
    
    func changePower(newPower: Int) {
        self.superheroPower = newPower
        self.superheroPowerImg = "ic_stars_\(newPower)"
        self.superheroDetailDataManager.changePowerSuperhero(newPower, withID: self.superheroID, completion: { result in
            if result {
                self.detailViewDelegate?.reloadData()
            }
        })
    }
    
    func backButtonTapped() {
        self.listViewDelegate?.reloadData()
    }
    
}
