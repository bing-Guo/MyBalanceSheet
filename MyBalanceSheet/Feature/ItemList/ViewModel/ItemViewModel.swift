import Foundation
import UIKit
import CoreData

class ItemViewModel {
    private let coreDataConnection = CoreDataConnction<Genre>()
    var sheetType: SheetType?
    var container: [ItemCellViewModel] = []
    var sortData: [GenreType: [ItemCellViewModel]] {
        var data = [GenreType: [ItemCellViewModel]]()
        data[.fixed] = self.container.filter({ $0.genreType == .fixed })
        data[.current] = self.container.filter({ $0.genreType == .current })
        return data
    }
    var title: String {
        switch sheetType! {
        case .asset:
            return "資產項目列表"
        case .liability:
            return "負債項目列表"
        }
    }
    var sectionTitle: [GenreType: String] {
        guard let type = sheetType else { fatalError("Cannot find correct sheet type") }
        switch type {
        case .asset:
            return [.fixed: "固定資產", .current: "流動資產"]
        case .liability:
            return [.fixed: "長期負債", .current: "流動負債"]
        }
    }
    
    func getGenreByID(id: UUID) -> Genre? {
        do {
            let data = try self.coreDataConnection.retrieve()
            let result = data.filter( {$0.id == id} )
            return result.first
        } catch {
            fatalError("An Error occurred to fetch sheet data from core data")
        }
    }
    
    func getGenreList() {
        do {
            let data = try self.coreDataConnection.retrieve()
            let filter = data.filter( {$0.sheetEnum == sheetType!} )
            
            self.container = filter.map( {ItemCellViewModel(genre: $0)} )
        } catch {
            fatalError("An Error occurred to fetch sheet data from core data")
        }
    }
    
    func insert(accountName: String, genreType: GenreType, icon: String, sheetType: SheetType) {
        let attributes: [String : Any] = [
            "id": UUID(),
            "accountName": accountName,
            "genreType": Int16(genreType.rawValue),
            "icon": icon,
            "sheetType": Int16(sheetType.rawValue)
        ]
        
        do {
            try coreDataConnection.insert(attributes: attributes)
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
    
    func checkGenreExistInSheet(genre: ItemCellViewModel) -> Bool{
        let sheetViewModel = SheetViewModel()
        let sheetData = sheetViewModel.getSheetByGenreID(genreID: genre.id!)
        return ( sheetData.count > 0 )
    }
}
