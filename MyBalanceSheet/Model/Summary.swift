import Foundation

enum summaryType: Int {
    case networth, asset, liability, debtRatio
}

struct Summary {
    let year: Int
    let month: Int
    let type: summaryType
    let amount: Int
    
    init(year: Int, month: Int, type: summaryType, amount: Int) {
        self.year = year
        self.month = month
        self.type = type
        self.amount = amount
        
    }
}
