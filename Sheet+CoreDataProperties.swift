//
//  Sheet+CoreDataProperties.swift
//  MyBalanceSheet
//
//  Created by Bing Guo on 2020/3/31.
//  Copyright © 2020 Bing Guo. All rights reserved.
//
//

import Foundation
import CoreData


extension Sheet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Sheet> {
        return NSFetchRequest<Sheet>(entityName: "Sheet")
    }

    @NSManaged public var amount: Int32
    @NSManaged public var id: UUID?
    @NSManaged public var month: Int16
    @NSManaged public var name: String?
    @NSManaged public var year: Int16
    @NSManaged public var genre: Genre?

}
