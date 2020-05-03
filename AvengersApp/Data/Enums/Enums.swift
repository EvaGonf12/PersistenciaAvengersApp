//
//  BDEnums.swift
//  AvengersApp
//
//  Created by Eva Gonzalez Ferreira on 23/04/2020.
//  Copyright © 2020 Eva Gonzalez Ferreira. All rights reserved.
//

import Foundation


enum EntityEnum: String {
    case Battle = "Battle"
    case Villain = "Villain"
    case Superhero = "Superhero"
}

enum SuperheroKeysEnum: String {
    case ID = "id"
    case Image = "image"
    case Name = "name"
    case Power = "power"
    case SuperheroDescription = "superheroDescription"
}

enum VillainKeysEnum: String {
    case ID = "id"
    case Image = "image"
    case Name = "name"
    case Power = "power"
    case SuperheroDescription = "superheroDescription"
}

enum BattleKeysEnum: String {
    case ID = "id"
    case name = "name"
    case winner = "winner"
}

enum Colors: String {
    case Pink = "ColoBgPink"
    case BlueBg = "ColorBlueBg"
    case Primary = "ColorBlueDark"
    case BlueNavBar = "ColorBlueNavBar"
    case DarkGray = "ColorGrayDark"
    case Red = "ColorRed"
    case TextBlue = "ColorTextBlue"
    case TextDark = "ColorTextDark"
    case WhiteBg = "ColorWhiteBg"
    case BlueSuperhero = "BlueSuperhero"
    case RedVillain = "RedVillain"
    case Win = "Win"
    case Lost = "Lost"
}

enum CompetitorType {
    case Villain
    case Superhero
}

enum WinnerEnum: String {
    case Villain = "Villain"
    case Superhero = "Superhero"
    case Empty = "Empty"
}
