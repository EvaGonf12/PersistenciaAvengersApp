//
//  SuperherosViewModel.swift
//  AvengersApp
//
//  Created by Eva Gonzalez Ferreira on 24/04/2020.
//  Copyright © 2020 Eva Gonzalez Ferreira. All rights reserved.
//

import UIKit

protocol SuperheroesViewDelegate: class {
    func superHeroesFetched()
    func changeToDetail(detailViewModel: SuperheroDetailViewModel)
    func reloadData()
}

class SuperheroesViewModel {

    weak var viewDelegate: SuperheroesViewDelegate?
    let superheroesDataManager: SuperherosDataManager
    let superheroDetailDataManager : SuperheroDetailDataManager
    var superheroesViewModels: [SuperheroCellViewModel] = []

    init(superHeroesDataManager: SuperherosDataManager,
         superheroDetailDataManager: SuperheroDetailDataManager) {
        self.superheroesDataManager = superHeroesDataManager
        self.superheroDetailDataManager = superheroDetailDataManager
    }
    
    fileprivate func fetchSuperHeroesAndReloadUI() {
        self.superheroesViewModels = superheroesDataManager.fetchAllSuperHeroes().map({ SuperheroCellViewModel(superhero: $0) })
        self.viewDelegate?.superHeroesFetched()
    }

    func viewWasLoaded() {
        fetchSuperHeroesAndReloadUI()
    }

    func numberOfSections() -> Int {
        return 1
    }

    func numberOfRows(in section: Int) -> Int {
        return superheroesViewModels.count
    }

    func viewModel(at indexPath: IndexPath) -> SuperheroCellViewModel? {
        guard indexPath.row < superheroesViewModels.count else { return nil }
        return superheroesViewModels[indexPath.row]
    }

    func didSelectRow(at indexPath: IndexPath) {
        guard indexPath.row < superheroesViewModels.count else { return }
        let superhero = self.superheroesViewModels[indexPath.row]
        let superheroDetailViewModel = SuperheroDetailViewModel(superheroID: superhero.superheroID,
                                                                       superheroDetailDataManager: self.superheroDetailDataManager)
        self.viewDelegate?.changeToDetail(detailViewModel: superheroDetailViewModel)

    }
}
