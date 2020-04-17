import Foundation
import UIKit
import CoreData

class SheetViewModel {
    private let coreDataConnection = CoreDataConnction<Sheet>()
    var container: [SheetCellViewModel] = []
    var sortData: [GenreType: [SheetCellViewModel]] {
        var data = [GenreType: [SheetCellViewModel]]()
        data[.fixed] = self.container.filter( {$0.genre.genreType == .fixed} )
        data[.current] = self.container.filter( {$0.genre.genreType == .current} )
        
        return data
    }
    
    func getSheetByID(id: UUID) -> Sheet? {
        do {
            let data = try self.coreDataConnection.retrieve()
            let result = data.filter( {$0.id == id} )
            return result.first
        } catch {
            fatalError("An Error occurred to fetch sheet data from core data")
        }
    }
    
    func getSheetByGenreID(genreID: UUID) -> [Sheet] {
        do {
            let data = try self.coreDataConnection.retrieve()
            let result = data.filter( {$0.genre!.id == genreID} )
            return result
        } catch {
            fatalError("An Error occurred to fetch sheet data from core data")
        }
    }
    
    func getSheetList(sheetType: SheetType, year: Int, month: Int) {
        do {
            let data = try self.coreDataConnection.retrieve()
            let filter = data.filter({
                $0.genre?.sheetEnum == .asset &&
                $0.year == year &&
                $0.month == month
            })
            
            self.container = filter.map( {SheetCellViewModel(sheet: $0)} )
        } catch {
            fatalError("An Error occurred to fetch sheet data from core data")
        }
    }
    
    func insert(name: String, year: Int, month: Int, genre: ItemCellViewModel, amount: Int) {
        let itemViewModel = ItemViewModel()
        guard let genreObj = itemViewModel.getGenreByID(id: genre.id!) else {
            fatalError("Cannot find genre.")
        }
        let attributes: [String : Any] = [
            "id": UUID(),
            "name": name,
            "year": Int16(year),
            "month": Int16(month),
            "genre": genreObj,
            "amount": Int32(amount)
        ]
        
        do {
            try coreDataConnection.insert(attributes: attributes)
        } catch {
            fatalError("An Error occurred to fetch sheet data from core data")
        }
    }
    
    func update(id: UUID, name: String, year: Int, month: Int, genre: ItemCellViewModel, amount: Int) {
        let itemViewModel = ItemViewModel()
        guard let genreObj = itemViewModel.getGenreByID(id: genre.id!) else {
            fatalError("Cannot find genre.")
        }
        let predicate = NSPredicate(format: "id = %@", argumentArray: [id])
        let attributes: [String : Any] = [
            "name": name,
            "year": Int16(year),
            "month": Int16(month),
            "genre": genreObj,
            "amount": Int32(amount)
        ]
        
        do {
            try coreDataConnection.update(predicate: predicate, attributes: attributes)
        } catch {
            fatalError("An Error occurred to fetch sheet data from core data")
        }
    }
    
    func delete(id: UUID) {
        do {
            let predicate = NSPredicate(format: "id = %@", argumentArray: [id])
            try coreDataConnection.delete(predicate: predicate)
        } catch {
            fatalError("An Error occurred to fetch sheet data from core data")
        }
    }
}
