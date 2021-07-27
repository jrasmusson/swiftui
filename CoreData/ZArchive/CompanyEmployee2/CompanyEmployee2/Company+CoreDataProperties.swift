//
//  Company+CoreDataProperties.swift
//  CompanyEmployee2
//
//  Created by jrasmusson on 2021-07-19.
//
//

import Foundation
import CoreData


extension Company {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Company> {
        return NSFetchRequest<Company>(entityName: "Company")
    }

    @NSManaged public var name: String?
    @NSManaged public var employees: NSSet?

    public var unwrappedName: String {
        name ?? "Unknown name"
    }

    public var employeesArray: [Employee] {
        let employeeSet = employees as? Set<Employee> ?? []
        
        return employeeSet.sorted {
            $0.unwrappedName < $1.unwrappedName
        }
    }
}

// MARK: Generated accessors for employees
extension Company {

    @objc(addEmployeesObject:)
    @NSManaged public func addToEmployees(_ value: Employee)

    @objc(removeEmployeesObject:)
    @NSManaged public func removeFromEmployees(_ value: Employee)

    @objc(addEmployees:)
    @NSManaged public func addToEmployees(_ values: NSSet)

    @objc(removeEmployees:)
    @NSManaged public func removeFromEmployees(_ values: NSSet)

}

extension Company : Identifiable {

}
