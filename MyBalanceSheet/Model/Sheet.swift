import Foundation

struct Sheet {
    var id: String
    var name: String
    var year: Int
    var month: Int
    var genre: Genre
    var amount: Int
    
    init(id: String, name: String, year: Int, month: Int, genre: Genre, amount: Int) {
        self.id = id
        self.name = name
        self.year = year
        self.month = month
        self.genre = genre
        self.amount = amount
    }
}

