import Foundation

enum RateStatue: Int {
    case up, down, flat, none
}

class SheetListViewModel {
    
    let year: Int
    let month: Int
    let genre: SheetGenreListViewModel
    let amount: Int
    let amountString: String
    let rateStatue: RateStatue
    let rateString: String
    
    init(sheet: Sheet, prevMonthSheet: Sheet?) {
        self.year = sheet.year
        self.month = sheet.month
        self.genre = SheetGenreListViewModel(genre: sheet.genre)
        self.amount = sheet.amount
        self.amountString = SheetListViewModel.moneyFormat(sheet.amount)
        
        if let prev = prevMonthSheet {
            let rate = Float(sheet.amount - prev.amount) / Float(prev.amount)
            print("\(rate), \(Float(sheet.amount - prev.amount)), \(Float(prev.amount))")
            
            let rateCeil = Int(ceil(rate * 100))
            self.rateString = SheetListViewModel.rateStringFormate(rateCeil)
            
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
    
    static func rateStringFormate(_ value: Int) -> String {
        if value < 10000 {
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
    
}
