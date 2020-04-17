import Foundation

class SummaryCellViewModel {
    let cellType: SummaryCellType
    let amount: Int
    var amountString: String {
        if cellType == .debtRatio {
            return "\(Int(self.amount))%"
        }
        return String(Int(self.amount)).moneyFormat()
    }
    let rate: Int?
    var rateString: String {
        guard let rate = self.rate else { return "" }
        return rate.isBetweenPlusMinusTenKilo() ? "\(rate)%" : "超過10,000%"
    }
    var rateState: RateState {
        guard let rate = self.rate else { return .none }
        if rate == 0 {
            return .flat
        } else if rate > 0 {
            return .up
        } else if rate < 0 {
            return .down
        } else {
            return .none
        }
    }
    
    init(cellType: SummaryCellType, amount: Int, rate: Int?) {
        self.cellType = cellType
        self.amount = amount
        self.rate = rate
    }
}
