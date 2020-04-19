import Foundation

struct Summary {
    let assetAmount: Int
    let liabilityAmount: Int
    var networth: Int {
        return assetAmount - liabilityAmount
    }
    var debtRatio: Int {
        let r = ceil(Float(liabilityAmount) / Float(assetAmount) * 100)
        if r.isNanOrInfinite() {
            return 0
        } else {
            return Int(r)
        }
    }
    
    init(assetAmount: Int, liabilityAmount: Int) {
        self.assetAmount = assetAmount
        self.liabilityAmount = liabilityAmount
    }
    
    init(sheets: [Sheet]) {
        let assets = sheets.filter( {$0.genre?.sheetEnum == .asset } )
        let liabilities = sheets.filter( {$0.genre?.sheetEnum == .liability } )
        let totalAssets = assets.compactMap( {Int($0.amount)} ).reduce(0, +)
        let totalLiabilities = liabilities.compactMap( {Int($0.amount)} ).reduce(0, +)
        self.init(assetAmount: totalAssets, liabilityAmount: totalLiabilities)
    }
}
