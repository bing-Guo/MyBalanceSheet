import Foundation

class GenreManager {
    func getAssetGenreList() -> [SheetGenreListViewModel] {
        var result = [SheetGenreListViewModel]()
        let genreData = Database.assetGenres
        
        for genre in genreData {
            result.append(SheetGenreListViewModel.init(genre: genre))
        }
        
        return result
    }
    
    func getLiabilityGenreList() -> [SheetGenreListViewModel] {
        var result = [SheetGenreListViewModel]()
        let genreData = Database.liabilityGenres
        
        for genre in genreData {
            result.append(SheetGenreListViewModel.init(genre: genre))
        }
        
        return result
    }
}
