import Foundation

enum SummaryType: Int {
    case networth, asset, liability, debtRatio
}

struct Summary {
    let year: Int
    let month: Int
    let type: SummaryType
    let amount: Int
    
    init(year: Int, month: Int, type: SummaryType, amount: Int) {
        self.year = year
        self.month = month
        self.type = type
        self.amount = amount
    }
}
