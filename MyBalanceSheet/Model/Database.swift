import Foundation

class Database {
    
//    
//    static var sheets: [Sheet] = [
//        Sheet(id: "S0001", name: "現金", year: 2019, month: 12, genre: genres[0], amount: 20),
//        Sheet(id: "S0002", name: "二手中古車", year: 2020, month: 1, genre: genres[9], amount: 2000),
//        Sheet(id: "S0003", name: "現金", year: 2020, month: 2, genre: genres[0], amount: 20),
//        Sheet(id: "S0004", name: "中信活存", year: 2020, month: 2, genre: genres[1], amount: 150),
//        Sheet(id: "S0005", name: "現金", year: 2020, month: 3, genre: genres[0], amount: 250),
//        Sheet(id: "S0006", name: "中信活存", year: 2020, month: 3, genre: genres[1], amount: 200),
//        Sheet(id: "S0007", name: "二手中古車", year: 2020, month: 3, genre: genres[9], amount: 400),
//        Sheet(id: "S0008", name: "蘆洲三樓公寓", year: 2020, month: 3, genre: genres[10], amount: 1200),
//        Sheet(id: "S0009", name: "玉山UBear", year: 2020, month: 2, genre: genres[12], amount: 20),
//        Sheet(id: "S0010", name: "二手中古車60期", year: 2020, month: 2, genre: genres[17], amount: 150),
//        Sheet(id: "S0011", name: "房貸120期", year: 2020, month: 2, genre: genres[18], amount: 250),
//        Sheet(id: "S0012", name: "孝親費", year: 2020, month: 2, genre: genres[14], amount: 500),
//        Sheet(id: "S0013", name: "玉山UBear", year: 2020, month: 3, genre: genres[12], amount: 500),
//        Sheet(id: "S0014", name: "二手中古車60期", year: 2020, month: 3, genre: genres[17], amount: 150),
//        Sheet(id: "S0015", name: "房貸120期", year: 2020, month: 3, genre: genres[18], amount: 500),
//        Sheet(id: "S0016", name: "孝親費", year: 2020, month: 3, genre: genres[14], amount: 500000000)
//    ]
//    
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
