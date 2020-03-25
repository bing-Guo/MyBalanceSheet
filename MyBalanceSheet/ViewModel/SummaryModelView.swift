import Foundation

class SummaryModelView {
    let year: Int
    let month: Int
    let type: summaryType
    let amountString: String
    let rateString: String
    
    init(summary: Summary, prevSummary: Summary?) {
        self.year = summary.year
        self.month = summary.month
        self.type = summary.type
        self.amountString = SheetListViewModel.moneyFormat(summary.amount)
        
        if let prev = prevSummary {
            let rate = Float(summary.amount - prev.amount) / Float(summary.amount)
            self.rateString = "\(rate)%"
        }else{
            self.rateString = "-"
        }
    }
    
    static func moneyFormat(_ value: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter.string(from: NSNumber(value: value))!
    }
}
