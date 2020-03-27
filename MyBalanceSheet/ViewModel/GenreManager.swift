import Foundation

class GenreManager {
    func getAssetGenreList() -> [SheetGenreListViewModel] {
        var result = [SheetGenreListViewModel]()
        let genreData = Database.genres.filter( {$0.sheetType == .asset} )
        
        for genre in genreData {
            result.append(SheetGenreListViewModel.init(genre: genre))
        }
        
        return result
    }
    
    func getLiabilityGenreList() -> [SheetGenreListViewModel] {
        var result = [SheetGenreListViewModel]()
        let genreData = Database.genres.filter( {$0.sheetType == .liability} )
        
        for genre in genreData {
            result.append(SheetGenreListViewModel.init(genre: genre))
        }
        
        return result
    }
}
