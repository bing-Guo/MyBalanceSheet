import Foundation

class SheetManager {
    func getAssetList() -> [AssetListViewModel] {
        var result = [AssetListViewModel]()
        let sheetsData = Database.assetSheets
        var match = false
        
        for first in sheetsData {
            match = false
            
            for second in sheetsData {
                if first.year == second.year &&
                    first.month-1 == second.month &&
                    first.genre.id == second.genre.id {
                    
                    let vm = AssetListViewModel(sheet: first, prevMonthSheet: second)
                    result.append(vm)
                    
                    match = true
                    break
                }
            }
            if match {
                continue
            } else {
                let vm = AssetListViewModel(sheet: first, prevMonthSheet: nil)
                result.append(vm)
            }
            
        }
        
        return result
    }
    
}
