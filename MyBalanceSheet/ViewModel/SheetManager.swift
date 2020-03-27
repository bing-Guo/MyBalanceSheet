import Foundation

class SheetManager {
    
    static var shareInstance = SheetManager()
    
    private init() {}
    
    func isSheetExisted(sheetData: Sheet) -> Bool {
        let year = sheetData.year
        let month = sheetData.month
        let genreID = sheetData.genre.id
        
        let filterData = Database.sheets.filter( {
            $0.year == year &&
            $0.month == month &&
            $0.genre.id == genreID
        } )
        
        return ( filterData.count > 0 )
    }
    
    func addSheet(sheet: Sheet) {
        Database.sheets.append(sheet)
    }
    
    func updateSheet(sheetData: Sheet) -> Bool {
        let id = sheetData.id
        
        for index in 0..<Database.sheets.count {
            let sheet = Database.sheets[index]
            if sheet.id == id {
                Database.sheets[index].name = sheetData.name
                Database.sheets[index].amount = sheetData.amount
                Database.sheets[index].year = sheetData.year
                Database.sheets[index].month = sheetData.month
                Database.sheets[index].genre = sheetData.genre
            }
        }
        
        return true
    }
    
    func getAssetList() -> [SheetListViewModel] {
        var result = [SheetListViewModel]()
        let sheetsData = Database.sheets.filter( {$0.genre.sheetType == .asset} )
        
        for sheet in sheetsData {
            let vm = SheetListViewModel(sheet: sheet)
            result.append(vm)
        }
        
        return result
    }
    
    func getLiabilityList() -> [SheetListViewModel] {
        var result = [SheetListViewModel]()
        let sheetsData = Database.sheets.filter( {$0.genre.sheetType == .liability} )
        
        for sheet in sheetsData {
            let vm = SheetListViewModel(sheet: sheet)
            result.append(vm)
        }
        
        return result
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
        let sheetData = Database.sheets
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
        let filterSheet = sheets.filter( {$0.genre.sheetType == .asset } )
        
        for sheet in filterSheet {
            result += sheet.amount
        }
        
        return result
    }
    
    private func caculateTotalLiability(_ sheets: [Sheet]) -> Int {
        var result = 0
        let filterSheet = sheets.filter( {$0.genre.sheetType == .liability } )
        
        for sheet in filterSheet {
            result += sheet.amount
        }
        
        return result
    }
    
    private func caculateNetworth(totalAsset: Int, totalLiability: Int) -> Int {
        return totalAsset + (-totalLiability)
    }
    
    private func caculateDebtRatio(totalAsset: Int, totalLiability: Int) -> Int {
        return Int(ceil(Float(totalLiability) / Float(totalAsset) * 100))
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
