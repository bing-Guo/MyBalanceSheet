import Foundation

extension Date {
    static func getYear(_ date: Date = Date()) -> Int {
        return Calendar.current.component(.year, from: date)
    }
    
    static func getMonth(_ date: Date = Date()) -> Int {
        return Calendar.current.component(.month, from: date)
    }
}
