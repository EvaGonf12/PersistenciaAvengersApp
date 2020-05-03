//
//  ListCompetitorViewModel.swift
//  AvengersApp
//
//  Created by Eva Gonzalez Ferreira on 02/05/2020.
//  Copyright © 2020 Eva Gonzalez Ferreira. All rights reserved.
//

import UIKit

protocol ListCompetitorViewDelegate: class {
    func competitorsFetched()
    func reloadData()
    func closeView()
}

class ListCompetitorViewModel {
    
    weak var listCompetitorViewDelegate: ListCompetitorViewDelegate?
    weak var createBattleDelegate: CreateBattleViewDelegate?
    
    var competitorsViewModels: [ListCompetitorCellViewModel] = []
    var type: CompetitorType?

    convenience init(superheros: [Superhero]) {
        self.init()
        type = .Superhero
        competitorsViewModels = superheros.map({ ListCompetitorCellViewModel(competitor: $0) })
    }
    
    convenience init(villains: [Villain]) {
        self.init()
        type = .Villain
        competitorsViewModels = villains.map({ ListCompetitorCellViewModel(competitor: $0) })
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(in section: Int) -> Int {
        return competitorsViewModels.count
    }
    
    func viewModel(at indexPath: IndexPath) -> ListCompetitorCellViewModel? {
        guard indexPath.row < competitorsViewModels.count else { return nil }
        return competitorsViewModels[indexPath.row]
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        guard indexPath.row < competitorsViewModels.count,
              let type = self.type else { return }
        let competitor = self.competitorsViewModels[indexPath.row]
        createBattleDelegate?.competitorSelected(type: type, competitor.id)
        listCompetitorViewDelegate?.closeView()
    }
}

