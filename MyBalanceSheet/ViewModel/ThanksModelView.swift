import Foundation

class ThanksModelView {
    let type: ThanksType
    let format: String
    let links: [Link]
    var display: String {
        guard links.count > 0 else { return "" }
        
        var string = links[0].string
        for index in 1..<links.count {
            string += " - \(links[index].string)"
        }
        return string
    }
    
    init(thanks: Thanks) {
        self.type = thanks.type
        self.format = thanks.format
        self.links = thanks.links
    }
}
