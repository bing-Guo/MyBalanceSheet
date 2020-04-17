import Foundation
import CoreData

class SummaryViewModel {
    private let coreDataConnection = CoreDataConnction<Sheet>()
    var container = [SummaryCellType: SummaryCellViewModel]()
    var isEmpty: Bool {
        print(self.container.count)
        return self.container.count == 0
    }
    private var sheetViewModel: SheetViewModel = SheetViewModel()
    
    func getSummarySheet(year: Int, month: Int) {
        let previousSheet: [Sheet]
        let currentSheet: [Sheet]
        let previousYear = (month - 1 == 0) ? (year - 1) : year
        let previousMonth = (month - 1 == 0) ? 12 : (month - 1)
        let previousPredicate = NSPredicate(format: "year = %@ and month = %@", argumentArray: [previousYear, previousMonth])
        let currentPredicate = NSPredicate(format: "year = %@ and month = %@", argumentArray: [year, month])
        
        do {
            currentSheet = try self.coreDataConnection.retrieve(predicate: currentPredicate)
            previousSheet = try self.coreDataConnection.retrieve(predicate: previousPredicate)
        } catch {
            fatalError("Cannot fetch data.")
        }
        
        if currentSheet.count > 0 {
            buildSummaryCell(currentSheet: currentSheet, previousSheet: previousSheet)
        } else {
            self.container = [SummaryCellType: SummaryCellViewModel]()
        }
    }
    
    func buildSummaryCell(currentSheet: [Sheet], previousSheet: [Sheet]) {
        let currentSummary = buildSummary(sheets: currentSheet)
        let previousSummery = buildSummary(sheets: previousSheet)
        
        self.container[.asset] = SummaryCellViewModel(cellType: .asset, amount: currentSummary.assetAmount,
                                                      rate: caculateRate(current: currentSummary.assetAmount, previous: previousSummery.assetAmount))
        self.container[.liability] = SummaryCellViewModel(cellType: .liability, amount: currentSummary.liabilityAmount,
                                                          rate: caculateRate(current: currentSummary.liabilityAmount, previous: previousSummery.liabilityAmount))
        self.container[.networth] = SummaryCellViewModel(cellType: .networth, amount: currentSummary.networth,
                                                         rate: caculateRate(current: currentSummary.networth, previous: previousSummery.networth))
        self.container[.debtRatio] = SummaryCellViewModel(cellType: .debtRatio, amount: currentSummary.debtRatio, rate: nil)
    }
    
    private func buildSummary(sheets: [Sheet]) -> Summary {
        let assets = sheets.filter( {$0.genre?.sheetEnum == .asset } )
        let liabilities = sheets.filter( {$0.genre?.sheetEnum == .liability } )
        let totalAssets = assets.compactMap( {Int($0.amount)} ).reduce(0, +)
        let totalLiabilities = liabilities.compactMap( {Int($0.amount)} ).reduce(0, +)
        return Summary(assetAmount: totalAssets, liabilityAmount: totalLiabilities)
    }
    
    private func caculateRate(current: Int, previous: Int) -> Int? {
        let rate = Float(current - previous) / Float(abs(previous))
        
        if !rate.isNanOrInfinite() {
            return Int(rate * 100)
        }
        
        return nil
    }
    
}
