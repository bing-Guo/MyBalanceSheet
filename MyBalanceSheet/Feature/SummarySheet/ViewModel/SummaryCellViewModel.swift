import Foundation
import UIKit

class SummaryCellViewModel {
    let cellTypeName: String
    let cellType: SummaryCellType
    let amount: Int
    let rate: Int?
    var amountString: String {
        if cellType == .debtRatio {
            return "\(Int(self.amount))%"
        }
        return String(Int(self.amount)).moneyFormat()
    }
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
    var rateStateIcon: UIImage? {
        switch rateState {
        case .up:
            return UIImage(systemName: "arrowtriangle.up.fill")!
        case .down:
            return UIImage(systemName: "arrowtriangle.down.fill")!
        case .flat:
            return UIImage(systemName: "minus")!
        case .none:
            return nil
        }
    }
    var reverse: Bool {
        return cellType == .liability
    }
    var textColor: UIColor? {
        switch rateState {
        case .up:
            return (reverse) ? ._liability_background : ._asset_background
        case .down:
            return (reverse) ? ._asset_background : ._liability_background
        case .flat:
            return .black
        case .none:
            return nil
        }
    }
    
    init(cellTypeName: String, cellType: SummaryCellType, amount: Int, rate: Int?) {
        self.cellTypeName = cellTypeName
        self.cellType = cellType
        self.amount = amount
        self.rate = rate
    }
}
