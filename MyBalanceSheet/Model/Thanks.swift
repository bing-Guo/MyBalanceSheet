import Foundation

enum ThanksType: Int {
    case icons
}
struct Link {
    let string: String
    let link: String
    
    init(string: String, link: String) {
        self.string = string
        self.link = link
    }
}

struct Thanks {
    let format: String
    let links: [Link]
    let type: ThanksType
    
    init(type: ThanksType, format: String, links: [Link]) {
        self.format = format
        self.links = links
        self.type = type
    }
}
