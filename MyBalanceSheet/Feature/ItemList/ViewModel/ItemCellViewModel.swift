import Foundation

class ItemCellViewModel {
    let id: UUID?
    let sheetType: SheetType
    let genreType: GenreType
    let accountName: String
    let icon: String
    
    init(genre: Genre) {
        self.id = genre.id
        self.sheetType = genre.sheetEnum
        self.genreType = genre.genreEnum
        // todo
        self.accountName = genre.accountName ?? ""
        self.icon = genre.icon ?? ""
    }
}
