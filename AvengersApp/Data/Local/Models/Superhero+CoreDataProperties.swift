//
//  Superhero+CoreDataProperties.swift
//  AvengersApp
//
//  Created by Eva Gonzalez Ferreira on 25/04/2020.
//  Copyright © 2020 Eva Gonzalez Ferreira. All rights reserved.
//
//

import Foundation
import CoreData


extension Superhero: Codable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Superhero> {
        return NSFetchRequest<Superhero>(entityName: "Superhero")
    }

    @NSManaged public var id: Int16
    @NSManaged public var image: String?
    @NSManaged public var name: String?
    @NSManaged public var power: Int16
    @NSManaged public var superheroDescription: String?

    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case image = "image"
        case power = "power"
        case superheroDescription = "superheroDescription"
        //case battles
    }
    
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.image, forKey: .image)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.power, forKey: .power)
        try container.encode(self.superheroDescription, forKey: .superheroDescription)
    }
}
