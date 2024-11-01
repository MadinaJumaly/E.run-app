//
//  Date+Ext.swift
//  E.run
//
//  Created by Madina Jumaly on 26.10.2024.
//

import Foundation

extension Date {
    func formatDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.string(from: self)
    }
    
    func timeOfDayString() -> String {
        let hour = Calendar.current.component(.hour, from: self)
        switch hour {
        case 3..<11:
            return "Morning Run"
        case 11..<15:
            return "Lunch Run"
        case 17..<22:
            return "Evening Run"
        default:
            return "Nightowl Run"
        }
    }
}
