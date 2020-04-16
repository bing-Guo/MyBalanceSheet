import Foundation
import UIKit
import CoreData

class GenreManager {
    
    static var shareInstance = GenreManager()
    
    private init() {}
    
    func getGenreFromCoreData() -> [Genre]{
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let request: NSFetchRequest<Genre> = Genre.fetchRequest()
            let context = appDelegate.persistentContainer.viewContext
            do {
                return try context.fetch(request)
            } catch {
                fatalError("An Error occurred to fetch sheet data from core date")
            }
        }
        return [Genre]()
    }
    
    func getGenreByID(id: UUID) -> Genre {
        let data = getGenreFromCoreData()
        
        let result = data.filter( {$0.id == id} )
        
        return result[0]
    }
    
    func getAssetGenreList() -> [SheetGenreListViewModel] {
        var result = [SheetGenreListViewModel]()
        let genreData = getGenreFromCoreData()
        let assetGenreData = genreData.filter( {$0.sheetEnum == .asset} )
        
        for genre in assetGenreData {
            result.append(SheetGenreListViewModel.init(genre: genre))
        }
        
        return result
    }
    
    func getLiabilityGenreList() -> [SheetGenreListViewModel] {
        var result = [SheetGenreListViewModel]()
        let genreData = getGenreFromCoreData()
        let liabilityGenreData = genreData.filter( {$0.sheetEnum == .liability} )
        
        for genre in liabilityGenreData {
            result.append(SheetGenreListViewModel.init(genre: genre))
        }
        
        return result
    }
    
    func addGenre(accountName: String, genreType: GenreType, icon: String, sheetType: SheetType) {
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let genre = Genre(context: appDelegate.persistentContainer.viewContext)
            genre.accountName = accountName
            genre.id = UUID()
            genre.genreType = Int16(genreType.rawValue)
            genre.icon = icon
            genre.sheetType = Int16(sheetType.rawValue)
            
            appDelegate.saveContext()
        }
    }
   
    func deleteGenre(id: UUID) {
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let request: NSFetchRequest<Genre> = Genre.fetchRequest()
            let context = appDelegate.persistentContainer.viewContext
            request.predicate = NSPredicate(format: "id = %@", argumentArray: [id])
            
            do {
                let sheet = try context.fetch(request)
                
                let objectDelete = sheet[0] as NSManagedObject
                context.delete(objectDelete)
                
                do{
                    try context.save()
                }catch{
                    fatalError("An Error occurred to fetch sheet data from core date")
                }
            } catch {
                fatalError("An Error occurred to fetch sheet data from core date")
            }
        }
    }
    
    func checkGenreExistInSheet(genre: SheetGenreListViewModel) -> Bool{
        let sheetData = SheetManager.shareInstance.getSheetByGenreID(genreID: genre.id!)
        return ( sheetData.count > 0 )
    }
}
