import Foundation

class SummaryModelView {
    let year: Int
    let month: Int
    let type: SummaryType
    let amountString: String
    let rateStatue: RateStatue
    let rateString: String
    
    init(summary: Summary, prevSummary: Summary?) {
        self.year = summary.year
        self.month = summary.month
        self.type = summary.type
        self.amountString = (summary.type == .debtRatio) ? "\(summary.amount)%" : SheetListViewModel.moneyFormat(summary.amount)
        
        if let prev = prevSummary {
            if summary.type == .debtRatio {
                self.rateString = ""
                self.rateStatue = .none
            }else{
                let rate = Float(summary.amount - prev.amount) / Float(abs(prev.amount))
//                print("\(rate), \(Float(summary.amount - prev.amount)), \(Float(abs(prev.amount)))")
                if SummaryModelView.checkAvailableFloat(rate) {
                    let rateCeil = Int(ceil(rate * 100))
                    self.rateString = SummaryModelView.rateStringFormate(rateCeil)
                    
                    if rateCeil == 0 {
                        self.rateStatue = .flat
                    }else if rateCeil > 0 {
                        self.rateStatue = .up
                    }else if rateCeil < 0 {
                        self.rateStatue = .down
                    }else{
                        self.rateStatue = .none
                    }
                }else{
                    self.rateString = ""
                    self.rateStatue = .none
                }
            }
        }else{
            self.rateString = ""
            self.rateStatue = .none
        }
    }
    
    static func rateStringFormate(_ value: Int) -> String {
        if value < 10000 && value > -10000{
            return "\(value)%"
        }else {
            return "超過10,000%"
        }
    }
    
    static func moneyFormat(_ value: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: value))!
    }
    
    static func checkAvailableFloat(_ value: Float) -> Bool {
        return !(value.isNaN || value.isInfinite)
    }
}
