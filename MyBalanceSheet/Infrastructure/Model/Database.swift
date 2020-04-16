import Foundation

class Database {
    
    static var thanks: [Thanks] = [
        Thanks(type: .icons,
               format: "Icon made by %@ perfect from %@",
               links: [Link(string: "Eucalyp", link: "https://www.flaticon.com/authors/eucalyp"),
                       Link(string: "www.flaticon.com", link: "https://www.flaticon.com/")]),
        Thanks(type: .icons,
        format: "Icon made by %@ perfect from %@",
        links: [Link(string: "Those Icons", link: "https://www.flaticon.com/authors/those-icons"),
                Link(string: "www.flaticon.com", link: "https://www.flaticon.com/")]),
        Thanks(type: .icons,
        format: "Icon made by %@ perfect from %@",
        links: [Link(string: "Ultimatearm", link: "https://www.flaticon.com/authors/ultimatearm"),
                Link(string: "www.flaticon.com", link: "https://www.flaticon.com/")]),
        Thanks(type: .icons,
        format: "Icon made by %@ perfect from %@",
        links: [Link(string: "Smashicons", link: "https://www.flaticon.com/authors/smashicons"),
                Link(string: "www.flaticon.com", link: "https://www.flaticon.com/")]),
        Thanks(type: .icons,
        format: "Icon made by %@ perfect from %@",
        links: [Link(string: "Freepik", link: "https://www.flaticon.com/authors/freepik"),
                Link(string: "www.flaticon.com", link: "https://www.flaticon.com/")])
    ]
    
    static var icons: [String] = [
        "money-1", "money-2", "bank", "bitcoin", "building", "coins", "financing", "stock", "stock-1", "wallet", "car", "credit-card-blue", "credit-card", "family", "insurance", "loan", "rice", "school"
    ]
    
    init() {}
}
