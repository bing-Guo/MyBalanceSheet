import Foundation
import UIKit
import CoreData

class SheetManager {
    
    static var shareInstance = SheetManager()
    
    private init() {}
    
    func getSheetFromCoreData() -> [Sheet]{
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let request: NSFetchRequest<Sheet> = Sheet.fetchRequest()
            let context = appDelegate.persistentContainer.viewContext
            do {
                return try context.fetch(request)
            } catch {
                fatalError("An Error occurred to fetch sheet data from core date")
            }
        }
        return [Sheet]()
    }
    
    func getSheetByID(id: UUID) -> Sheet {
        let data = getSheetFromCoreData()
        
        let result = data.filter( {$0.id == id} )
        
        return result[0]
    }
    
    func getSheetByGenreID(genreID: UUID) -> [Sheet] {
        let data = getSheetFromCoreData()
        
        let result = data.filter( {$0.genre!.id == genreID} )
        
        return result
    }
    
    // MARK: - 轉換ViewModel
    
    func getAssetList() -> [SheetListViewModel] {
        var result = [SheetListViewModel]()
        let sheetsData = getSheetFromCoreData()
        let assetSheetsData = sheetsData.filter( {$0.genre?.sheetEnum == .asset } )
        
        for sheet in assetSheetsData {
            let vm = SheetListViewModel(sheet: sheet)
            result.append(vm)
        }
        
        return result
    }
    
    func getLiabilityList() -> [SheetListViewModel] {
        var result = [SheetListViewModel]()
        let sheetsData = getSheetFromCoreData()
        let liabilitySheetsData = sheetsData.filter( {$0.genre?.sheetEnum == .liability } )
        
        for sheet in liabilitySheetsData {
            let vm = SheetListViewModel(sheet: sheet)
            result.append(vm)
        }
        
        return result
    }
    
    
    // MARK: -
    
    func addSheet(name: String, year: Int, month: Int, genre: Genre, amount: Int) {
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let sheet = Sheet(context: appDelegate.persistentContainer.viewContext)
            sheet.id = UUID()
            sheet.name = name
            sheet.year = Int16(year)
            sheet.month = Int16(month)
            sheet.genre = genre
            sheet.amount = Int32(amount)
            
            appDelegate.saveContext()
        }
    }
    
    func updateSheet(id: UUID, name: String, year: Int, month: Int, genre: Genre, amount: Int) {
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let request: NSFetchRequest<Sheet> = Sheet.fetchRequest()
            let context = appDelegate.persistentContainer.viewContext
            request.predicate = NSPredicate(format: "id = %@", argumentArray: [id])
            
            do {
                let sheet = try context.fetch(request)
                
                let objectUpdate = sheet[0] as NSManagedObject
                objectUpdate.setValue(name, forKey: "name")
                objectUpdate.setValue(Int16(year), forKey: "year")
                objectUpdate.setValue(Int16(month), forKey: "month")
                objectUpdate.setValue(genre, forKey: "genre")
                objectUpdate.setValue(Int32(amount), forKey: "amount")
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
    
    func deleteSheet(id: UUID) {
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let request: NSFetchRequest<Sheet> = Sheet.fetchRequest()
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
    
    func deleteAll() {
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let request: NSFetchRequest<Sheet> = Sheet.fetchRequest()
            let context = appDelegate.persistentContainer.viewContext
            let deleterequest = NSBatchDeleteRequest(fetchRequest: request as! NSFetchRequest<NSFetchRequestResult>)
            
            do {
                try context.execute(deleterequest)
            } catch {
                fatalError("An Error occurred to fetch sheet data from core date")
            }
        }
    }
    
    func getSummaryList() -> [SummaryModelView] {
        var result = [SummaryModelView]()
        let summaryDate = generateSummarySheet()
        var match = false
        
        for first in summaryDate {
            match = false
            
            for second in summaryDate {
                if isLastMonth(firstYear: first.year, secondYear: second.year, firstMonth: first.month, secondMonth: second.month)
                    && first.type == second.type {
                    
                    let vm = SummaryModelView(summary: first, prevSummary: second)
                    result.append(vm)
                    
                    match = true
                    break
                }
            }
            if match {
                continue
            } else {
                let vm = SummaryModelView(summary: first, prevSummary: nil)
                result.append(vm)
            }
            
        }
        
        return result
    }
    
    // MARK: - Helper
    
    private func generateSummarySheet() -> [Summary]{
        var result = [Summary]()
        let sheetData = getSheetFromCoreData()
        let groupDict = groupSameDateSheet(sheetData)
        
        for group in groupDict {
            let year = Int(group.key.split(separator: "/")[0])!
            let month = Int(group.key.split(separator: "/")[1])!
            
            let totalAsset = caculateTotalAsset(group.value)
            let totalLiability = caculateTotalLiability(group.value)
            let networth = caculateNetworth(totalAsset: totalAsset, totalLiability: totalLiability)
            let debtRatio = caculateDebtRatio(totalAsset: totalAsset, totalLiability: totalLiability)
            
            let networthSummary = Summary(year: year, month: month, type: .networth, amount: networth)
            let assetSummary = Summary(year: year, month: month, type: .asset, amount: totalAsset)
            let liabilitySummary = Summary(year: year, month: month, type: .liability, amount: totalLiability)
            let debtRatioSummary = Summary(year: year, month: month, type: .debtRatio, amount: debtRatio)
            
            result.append(networthSummary)
            result.append(assetSummary)
            result.append(liabilitySummary)
            result.append(debtRatioSummary)
        }
        return result
    }
    
    private func groupSameDateSheet(_ sheets: [Sheet]) -> [String: [Sheet]] {
          var result = [String: [Sheet]]()
          
          for sheet in sheets {
              let dateString = "\(sheet.year)/\(sheet.month)"
          
              if result[dateString] == nil {
                  result[dateString] = [Sheet]()
              }
              result[dateString]?.append(sheet)
          }
          
          return result
      }
    
    private func caculateTotalAsset(_ sheets: [Sheet]) -> Int {
        var result = 0
        let filterSheet = sheets.filter( {$0.genre?.sheetEnum == .asset } )
        
        for sheet in filterSheet {
            result += Int(sheet.amount)
        }
        
        return result
    }
    
    private func caculateTotalLiability(_ sheets: [Sheet]) -> Int {
        var result = 0
        let filterSheet = sheets.filter( {$0.genre?.sheetEnum == .liability } )
        
        for sheet in filterSheet {
            result += Int(sheet.amount)
        }
        
        return result
    }
    
    private func caculateNetworth(totalAsset: Int, totalLiability: Int) -> Int {
        return totalAsset + (-totalLiability)
    }
    
    private func caculateDebtRatio(totalAsset: Int, totalLiability: Int) -> Int {
        let r = ceil(Float(totalLiability) / Float(totalAsset) * 100)
        if r.isInfinite || r.isNaN{
            return 0
        }else{
            return Int(r)
        }
        
    }
    
    private func isLastMonth(firstYear: Int, secondYear: Int, firstMonth: Int, secondMonth: Int) -> Bool {
        let cond1 = firstYear == secondYear && (firstMonth-1) == secondMonth
        let cond2 = (firstYear-1) == secondYear && firstMonth == 1 && secondMonth == 12
        if cond1 || cond2 {
            return true
        }
        return false
    }
    
}
