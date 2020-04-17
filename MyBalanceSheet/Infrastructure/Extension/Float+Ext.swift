import Foundation

extension Float {
    func isNanOrInfinite() -> Bool {
        return (self.isNaN || self.isInfinite)
    }
}
