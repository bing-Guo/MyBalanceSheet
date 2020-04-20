import Foundation

extension String {
    func moneyFormat() -> String {
        let this = self
        let pattern = "(\\d{1,3})(?=(\\d{3})+$)"
        let regex = try! NSRegularExpression(pattern: pattern)
        let range = NSMakeRange(0, this.count)
        let result = regex.stringByReplacingMatches(in: this, options: [], range: range, withTemplate: "$1,")
        
        return "$\(result)"
    }
}
