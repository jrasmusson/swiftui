//
//  Employee+CoreDataProperties.swift
//  CoreDataIntro
//
//  Created by jrasmusson on 2021-07-26.
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
