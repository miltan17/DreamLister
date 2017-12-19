//
//  Item+CoreDataClass.swift
//  DreamLister
//
//  Created by Miltan on 12/19/17.
//  Copyright © 2017 Milton. All rights reserved.
//

import Foundation
import CoreData

@objc(Item)
public class Item: NSManagedObject {
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.created = NSDate() as NSDate?
    }
}
