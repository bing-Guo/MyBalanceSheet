import Foundation
import CoreData

class SummaryViewModel {
    private let coreDataConnection = CoreDataConnction<Sheet>()
    var container = [SummaryCellType: SummaryCellViewModel]()
    var isEmpty: Bool {
        print(self.container.count)
        return self.container.count == 0
    }
    
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
        let currentSummary = Summary(sheets: currentSheet)
        let previousSummery = Summary(sheets: previousSheet)
        
        self.container[.asset] = SummaryCellViewModel(cellTypeName: "淨值總計",
                                                      cellType: .asset, amount: currentSummary.assetAmount,
                                                      rate: caculateRate(current: currentSummary.assetAmount, previous: previousSummery.assetAmount))
        self.container[.liability] = SummaryCellViewModel(cellTypeName: "資產總計",
                                                          cellType: .liability, amount: currentSummary.liabilityAmount,
                                                          rate: caculateRate(current: currentSummary.liabilityAmount, previous: previousSummery.liabilityAmount))
        self.container[.networth] = SummaryCellViewModel(cellTypeName: "負債總計",
                                                         cellType: .networth, amount: currentSummary.networth,
                                                         rate: caculateRate(current: currentSummary.networth, previous: previousSummery.networth))
        self.container[.debtRatio] = SummaryCellViewModel(cellTypeName: "負債比率",
                                                          cellType: .debtRatio, amount: currentSummary.debtRatio, rate: nil)
    }
    
    private func caculateRate(current: Int, previous: Int) -> Int? {
        let rate = Float(current - previous) / Float(abs(previous))
        
        if !rate.isNanOrInfinite() {
            return Int(rate * 100)
        }
        
        return nil
    }
    
}
