//
//  Date+Extensions.swift
//  Utilities
//
//  Created by Ntobeko Sikithi on 2025/06/13.
//

import Foundation

public extension Date {
    func formatForDisplay() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
    
    func isInCurrentWeek() -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(self, equalTo: Date(), toGranularity: .weekOfYear)
    }
    
    func startOfWeek() -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)
        return calendar.date(from: components) ?? self
    }
    
    func endOfWeek() -> Date {
        let calendar = Calendar.current
        let startOfWeek = self.startOfWeek()
        return calendar.date(byAdding: .weekOfYear, value: 1, to: startOfWeek) ?? self
    }
}
