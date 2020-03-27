import Foundation

class SheetGenreListViewModel {
    
    let id: String
    let sheetType: SheetType
    let genreType: GenreType
    let accountName: String
    let icon: String
    
    init(genre: Genre) {
        self.id = genre.id
        self.sheetType = genre.sheetType
        self.genreType = genre.genreType
        self.accountName = genre.accountName
        self.icon = genre.icon
    }
}
