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
    
    func deleteGenre(genreID: String) {
        SheetManager.shareInstance.deleteSheetByGenreID(genreID: genreID)
        
        for index in 0..<Database.genres.count {
            let genre = Database.genres[index]
            if genre.id == genreID {
                Database.genres.remove(at: index)
                break
            }
        }
    }
    
    func checkGenreExistInSheet(genre: SheetGenreListViewModel) -> Bool{
        for index in 0..<Database.sheets.count {
            let sheet = Database.sheets[index]
            
            if sheet.genre.id == genre.id {
                return true
            }
        }
        return false
    }
}
