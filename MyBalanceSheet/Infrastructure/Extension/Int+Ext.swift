import Foundation

extension Int {
    func isBetweenPlusMinusTenKilo() -> Bool {
        return (self < 10000 && self > -10000)
    }
    
    func rateCeil() -> Int {
        return Int(ceil(Float(self/100)))
    }
}
