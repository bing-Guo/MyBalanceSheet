import Foundation

struct Sheet {
    let year: Int
    let month: Int
    let genre: Genre
    let amount: Int
    
    init(year: Int, month: Int, genre: Genre, amount: Int) {
        self.year = year
        self.month = month
        self.genre = genre
        self.amount = amount
    }
}

