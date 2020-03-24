import Foundation

class AssetListViewModel {
    
    let year: Int
    let month: Int
    let genre: Genre
    let amountString: String
    let rateString: String
    
    init(sheet: Sheet, prevMonthSheet: Sheet?) {
        self.year = sheet.year
        self.month = sheet.month
        self.genre = sheet.genre
        self.amountString = AssetListViewModel.moneyFormat(sheet.amount)
        
        if let prev = prevMonthSheet {
            let rate = Float(sheet.amount - prev.amount) / Float(sheet.amount)
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
