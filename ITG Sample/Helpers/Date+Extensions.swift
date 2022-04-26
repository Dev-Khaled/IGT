//
//  Date+Extensions.swift
//  Snackat
//
//  Created by Khaled Khaldi on 12/04/2022.
//

import Foundation

import Foundation

// extension DateFormatter {
//     // ----- Server Date Formatter ----- //
//     static let serverDateFormatter: DateFormatter = {
//         let formatter = DateFormatter()
//         formatter.dateFormat = "yyyy-MM-dd"
//         formatter.locale = Locale(identifier: "en_US_POSIX")
//         formatter.timeZone = TimeZone(identifier:"UTC")
//         return formatter
//     }()
//
//     static let serverTimeFormatter: DateFormatter = {
//         let formatter = DateFormatter()
//         formatter.dateFormat = "HH:mm:ss"
//         formatter.locale = Locale(identifier: "en_US_POSIX")
//         formatter.timeZone = TimeZone(identifier:"UTC")
//         return formatter
//     }()
//
//     static let serverDateTimeFormatter: DateFormatter = {
//         let formatter = DateFormatter()
//         formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSXXX" //2019-08-19T11:47:46.56Z
//         formatter.locale = Locale(identifier: "en_US_POSIX")
//         formatter.timeZone = TimeZone(identifier:"UTC")
//         return formatter
//     }()
//
// }
//
// extension Date {
//     // Send to server
//     func stringFromDateForServer() -> String {
//         return DateFormatter.serverDateFormatter.string(from: self)
//     }
//
//     func stringFromTimeForServer() -> String {
//         return DateFormatter.serverTimeFormatter.string(from: self)
//     }
//
//     func stringFromDateTimeForServer() -> String {
//         return DateFormatter.serverDateTimeFormatter.string(from: self)
//     }
//
// }
//
//
// extension String {
//
//     // Received from server
//     func dateFromServerString() -> Date? {
//         return DateFormatter.serverDateFormatter.date(from: self)
//     }
//
//     func timeFromServerString() -> Date? {
//         return DateFormatter.serverTimeFormatter.date(from: self)
//     }
//
//     func dateTimeFromServerString() -> Date? {
//         return DateFormatter.serverDateTimeFormatter.date(from: self)
//     }
//
// }
//

/*
 Local
 */
extension DateFormatter {
    static let localDateFormatter: DateFormatter! = {
        let formatter = DateFormatter()
//        formatter.dateFormat = "EEE, dd MMM, yyyy"
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    static let localTimeFormatter: DateFormatter! = {
        let formatter = DateFormatter()
        // formatter.dateFormat = "HH:mm"
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter
    }()
    
    static let localDateTimeFormatter: DateFormatter! = {
        let formatter = DateFormatter()
        // formatter.dateFormat = "EEE, dd MMM yyyy, HH:mm"
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        
        return formatter
    }()
    
}


extension Date {
    func formattedDate() -> String {
        return DateFormatter.localDateFormatter.string(from: self)
    }
    
    func formattedTime() -> String {
        return DateFormatter.localTimeFormatter.string(from: self)
    }
    
    func formattedDateTime() -> String {
        return DateFormatter.localDateTimeFormatter.string(from: self)
    }
    
}
