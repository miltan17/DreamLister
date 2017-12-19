//
//  Item+CoreDataProperties.swift
//  DreamLister
//
//  Created by Miltan on 12/19/17.
//  Copyright © 2017 Milton. All rights reserved.
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item");
    }

    @NSManaged public var title: String?
    @NSManaged public var details: String?
    @NSManaged public var created: NSDate?
    @NSManaged public var price: Double
    @NSManaged public var toImage: Image?
    @NSManaged public var toItemType: ItemType?
    @NSManaged public var toStore: Store?

}
