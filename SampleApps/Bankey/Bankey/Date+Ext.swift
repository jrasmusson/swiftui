//
//  Date+Ext.swift
//  Bankey
//
//  Created by jrasmusson on 2022-06-24.
//

import Foundation

extension Date {
    static var bankeyDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "MDT")
        return formatter
    }

    var monthDayYearString: String {
        let dateFormatter = Date.bankeyDateFormatter
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: self)
    }

    func cutTimestamp() -> Date {
        let dateFormatter = Date.bankeyDateFormatter
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let str = dateFormatter.string(from: self)
        let date = dateFormatter.date(from: str)
        return date!
    }
}

func makeDate(day: Int, month: Int, year: Int) -> Date {
    let userCalendar = Calendar.current

    var components = DateComponents()
    components.year = year
    components.month = month
    components.day = day

    return userCalendar.date(from: components)!
}
