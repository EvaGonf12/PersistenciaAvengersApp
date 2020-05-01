//
//  Villain+CoreDataProperties.swift
//  AvengersApp
//
//  Created by Eva Gonzalez Ferreira on 01/05/2020.
//  Copyright © 2020 Eva Gonzalez Ferreira. All rights reserved.
//
//

import Foundation
import CoreData


extension Villain: Codable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Villain> {
        return NSFetchRequest<Villain>(entityName: "Villain")
    }

    @NSManaged public var id: Int16
    @NSManaged public var image: String?
    @NSManaged public var name: String?
    @NSManaged public var power: Int16
    @NSManaged public var villainDescription: String?

    enum VCodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case image = "image"
        case power = "power"
        case villainDescription = "villainDescription"
        //case battles
    }
    
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: VCodingKeys.self)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.image, forKey: .image)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.power, forKey: .power)
        try container.encode(self.villainDescription, forKey: .villainDescription)
    }
}
