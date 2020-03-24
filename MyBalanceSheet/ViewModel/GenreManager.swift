import Foundation

class GenreManager {
    func getAssetGenreList() -> [AssetGenreListViewModel] {
        var result = [AssetGenreListViewModel]()
        let genreData = Database.assetGenres
        
        for genre in genreData {
            result.append(AssetGenreListViewModel.init(genre: genre))
        }
        
        return result
    }
    
}
