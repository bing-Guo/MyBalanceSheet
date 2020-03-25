import Foundation

class SummaryModelView {
    let year: Int
    let month: Int
    let type: SummaryType
    let amountString: String
    let rateString: String
    
    init(summary: Summary, prevSummary: Summary?) {
        self.year = summary.year
        self.month = summary.month
        self.type = summary.type
        self.amountString = (summary.type == .debtRatio) ? "\(summary.amount)%" : SheetListViewModel.moneyFormat(summary.amount)
        
        if let prev = prevSummary {
            self.rateString = (summary.type == .debtRatio) ? "" : SummaryModelView.generateRateString(summary: summary, prev: prev)
        }else{
            self.rateString = ""
        }
    }
    
    static func generateRateString(summary: Summary, prev: Summary) -> String {
        let rate = Float(summary.amount - prev.amount) / Float(summary.amount)
            
        if SummaryModelView.checkAvailableFloat(rate) {
            let rateCeil = Int(ceil(rate * 100))
            return "\(rateCeil)%"
        }
        return ""
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
