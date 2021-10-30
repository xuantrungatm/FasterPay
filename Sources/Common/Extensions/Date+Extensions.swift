//
//  Date+Extensions.swift
//  MyApp
//
//

import Foundation

extension Date {
    private func getCalendar() -> Calendar {
        return Calendar(identifier: .gregorian)
    }
    
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
    
    func toString(format: String) -> String {
        let formater = DateFormatter()
        formater.dateFormat = format
        return formater.string(from: self)
    }
    
    static func getMonthAndYearBetween(from start: Date, to end: Date) -> [Date] {
        var allDates: [Date] = []
        guard start < end else { return allDates }
        
        let calendar = Calendar.current
        let month = calendar.dateComponents([.month], from: start, to: end).month ?? 0
        
        for i in 0...month {
            if let date = calendar.date(byAdding: .month, value: i, to: start) {
                allDates.append(date)
            }
        }
        return allDates
    }
    
    func getNextDay(day: Int) -> Date {
        return self.getCalendar().date(byAdding: .day, value: day, to: self)!
    }
    
    func getPrevDay(day: Int) -> Date {
        return self.getCalendar().date(byAdding: .day, value: -day, to: self)!
    }
}
