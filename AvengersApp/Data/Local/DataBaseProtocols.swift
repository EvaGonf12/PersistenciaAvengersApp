//
//  DataBaseProtocols.swift
//  AvengersApp
//
//  Created by Eva Gonzalez Ferreira on 26/04/2020.
//  Copyright © 2020 Eva Gonzalez Ferreira. All rights reserved.
//

import Foundation
import CoreData

protocol BattleDataBase {
    var entityBattle: EntityEnum { get }
    func createBattle(id: Int, name: String, villain: Villain, superhero: Superhero, winner: String)
    func fecthAllBattleData() -> [NSManagedObject]?
    func deleteBattle(data: [NSManagedObject]) -> Bool
}

protocol VillainDataBase {
    var entityVillain: EntityEnum { get }
    func fecthAllVillainData() -> [NSManagedObject]?
    func fetchVillain(byID id: Int) -> NSManagedObject?
    func initVillainData(_ heros: [StructVillain])
    func changeVillainPower(_ power: Int, withID id: Int) -> Bool
}

protocol SuperheroDataBase {
    var entitySuperhero: EntityEnum { get }
    func fecthAllSuperheroData() -> [NSManagedObject]?
    func fetchSuperhero(byID id: Int) -> NSManagedObject?
    func initSuperheroData(_ heros: [StructSuperhero])
    func changeSuperheroPower(_ power: Int, withID id: Int) -> Bool
}
