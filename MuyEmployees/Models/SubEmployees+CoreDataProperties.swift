//
//  SubEmployees+CoreDataProperties.swift
//  
//
//  Created by Daniel Steven Murcia Almanza on 28/08/20.
//
//

import Foundation
import CoreData


extension SubEmployees {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SubEmployees> {
        return NSFetchRequest<SubEmployees>(entityName: "SubEmployees")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var boss: Employee?

}
