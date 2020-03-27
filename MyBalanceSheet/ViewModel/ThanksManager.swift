import Foundation

class ThanksManager {
    func getThanksIconList() -> [ThanksModelView] {
        var result = [ThanksModelView]()
        let thanksData = Database.thanks.filter( {$0.type == .icons} )
        
        for thanks in thanksData {
            result.append(ThanksModelView.init(thanks: thanks))
        }
        
        return result
    }
}
