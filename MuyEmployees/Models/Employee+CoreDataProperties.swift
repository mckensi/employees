//
//  Employee+CoreDataProperties.swift
//  
//
//  Created by Daniel Steven Murcia Almanza on 28/08/20.
//
//

import Foundation
import CoreData


extension Employee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var position: String?
    @NSManaged public var wage: Int64
    @NSManaged public var subEmployees: NSSet?

}

// MARK: Generated accessors for subEmployees
extension Employee {

    @objc(addSubEmployeesObject:)
    @NSManaged public func addToSubEmployees(_ value: SubEmployees)

    @objc(removeSubEmployeesObject:)
    @NSManaged public func removeFromSubEmployees(_ value: SubEmployees)

    @objc(addSubEmployees:)
    @NSManaged public func addToSubEmployees(_ values: NSSet)

    @objc(removeSubEmployees:)
    @NSManaged public func removeFromSubEmployees(_ values: NSSet)

}
