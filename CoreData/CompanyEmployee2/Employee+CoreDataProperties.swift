//
//  Employee+CoreDataProperties.swift
//  CompanyEmployee2
//
//  Created by jrasmusson on 2021-07-19.
//
//

import Foundation
import CoreData


extension Employee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee")
    }

    @NSManaged public var name: String?
    @NSManaged public var company: Company?

    public var unwrappedName: String {
        name ?? "Unknown name"
    }
}

extension Employee : Identifiable {

}
