import Foundation

class SheetListViewModel {
    
    let year: Int
    let month: Int
    let genre: Genre
    let amountString: String
    let rateString: String
    
    init(sheet: Sheet, prevMonthSheet: Sheet?) {
        self.year = sheet.year
        self.month = sheet.month
        self.genre = sheet.genre
        self.amountString = SheetListViewModel.moneyFormat(sheet.amount)
        
        if let prev = prevMonthSheet {
            let rate = Float(sheet.amount - prev.amount) / Float(sheet.amount)
            let rateCeil = ceil(rate * 100)
            self.rateString = "\(rateCeil)%"
        }else{
            self.rateString = "-"
        }
    }
    
    static func moneyFormat(_ value: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: value))!
    }
}
