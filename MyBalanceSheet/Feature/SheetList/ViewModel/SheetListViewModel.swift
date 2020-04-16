import Foundation

enum RateStatue: Int {
    case up, down, flat, none
}

class SheetListViewModel {
    let id: UUID?
    let name: String
    let year: Int
    let month: Int
    let genre: SheetGenreListViewModel
    let amount: Int
    let amountString: String
    
    init(sheet: Sheet) {
        let amountString = String(Int(sheet.amount)).moneyFormat()
        
        self.id = sheet.id
        self.name = sheet.name ?? ""
        self.year = Int(sheet.year)
        self.month = Int(sheet.month)
        self.genre = SheetGenreListViewModel(genre: sheet.genre!)
        self.amount = Int(sheet.amount)
        self.amountString = amountString
    }
    
}


