import Foundation

class SheetGenreListViewModel {
    
    let id: String
    let mainGenre: String
    let subGenre: String
    let accountName: String
    
    init(genre: Genre) {
        self.id = genre.id
        self.mainGenre = genre.mainGenre
        self.subGenre = genre.subGenre
        self.accountName = genre.accountName
    }
}
