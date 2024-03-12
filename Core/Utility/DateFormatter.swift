//
//  DateFormatter.swift
//  NextTest
//
//  Created by Alin Zdurlan on 11.03.2024.
//

import Foundation

public enum DateFormat: String {
    /// June 16 2024
    case fulldate = "MMMM dd yyyy"
}

public enum DateUtil {
    /// Returns the string representation of a date
    ///
    /// - Parameters:
    ///   - date: the date object
    ///   - format: the requested date format
    /// - Returns: the formatted string representation of the date
    public static func format(date: Date, with format: DateFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.string(from: date)
    }

    /// Returns the date representation of a string
    ///
    /// - Parameters:
    ///   - dateString: the date in string format
    ///   - format: the requested date format
    /// - Returns: the date
    public static func date(from dateString: String, format: DateFormat, with timeZone: TimeZone? = nil) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        if let timeZone {
            formatter.timeZone = timeZone
        }
        return formatter.date(from: dateString)
    }
}
