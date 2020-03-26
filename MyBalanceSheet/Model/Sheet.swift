import Foundation

struct Sheet {
    var year: Int
    var month: Int
    var genre: Genre
    var amount: Int
    
    init(year: Int, month: Int, genre: Genre, amount: Int) {
        self.year = year
        self.month = month
        self.genre = genre
        self.amount = amount
    }
}

