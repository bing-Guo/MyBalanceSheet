import Foundation

class Database {
    static var genres: [Genre] = [
        Genre(id: "a0001", icon: "wallet", sheetType: .asset, genreType: .current, accountName: "現金"),
        Genre(id: "a0002", icon: "money-2", sheetType: .asset, genreType: .current, accountName: "活存"),
        Genre(id: "a0003", icon: "bank", sheetType: .asset, genreType: .current, accountName: "定存"),
        Genre(id: "a0005", icon: "bitcoin", sheetType: .asset, genreType: .current, accountName: "電子貨幣"),
        Genre(id: "a0006", icon: "stock", sheetType: .asset, genreType: .current, accountName: "股票"),
        Genre(id: "a0007", icon: "stock", sheetType: .asset, genreType: .current, accountName: "短期票券"),
        Genre(id: "a0008", icon: "stock", sheetType: .asset, genreType: .current, accountName: "公債"),
        Genre(id: "a0009", icon: "stock", sheetType: .asset, genreType: .current, accountName: "基金"),
        Genre(id: "a0010", icon: "money-1", sheetType: .asset, genreType: .current, accountName: "其他"),
        Genre(id: "a0011", icon: "car", sheetType: .asset, genreType: .fixed, accountName: "汽車"),
        Genre(id: "a0012", icon: "loan", sheetType: .asset, genreType: .fixed, accountName: "不動產"),
        Genre(id: "a0013", icon: "insurance", sheetType: .asset, genreType: .fixed, accountName: "儲蓄險"),
        Genre(id: "b0001", icon: "credit-card", sheetType: .liability, genreType: .current, accountName: "信用卡"),
        Genre(id: "b0002", icon: "family", sheetType: .liability, genreType: .current, accountName: "孝親費"),
        Genre(id: "b0003", icon: "building", sheetType: .liability, genreType: .current, accountName: "家用開銷"),
        Genre(id: "b0004", icon: "rice", sheetType: .liability, genreType: .current, accountName: "伙食費"),
        Genre(id: "b0005", icon: "school", sheetType: .liability, genreType: .fixed, accountName: "學貸"),
        Genre(id: "b0006", icon: "car", sheetType: .liability, genreType: .fixed, accountName: "車貸"),
        Genre(id: "b0007", icon: "loan", sheetType: .liability, genreType: .fixed, accountName: "房貸"),
        Genre(id: "b0008", icon: "insurance", sheetType: .liability, genreType: .fixed, accountName: "保單"),
    ]
    
    static var sheets: [Sheet] = [
        Sheet(id: "S0001", name: "現金", year: 2019, month: 12, genre: genres[0], amount: 20),
        Sheet(id: "S0002", name: "現金", year: 2020, month: 1, genre: genres[0], amount: 20),
        Sheet(id: "S0003", name: "現金", year: 2020, month: 2, genre: genres[0], amount: 20),
        Sheet(id: "S0004", name: "中信活存", year: 2020, month: 2, genre: genres[1], amount: 150),
        Sheet(id: "S0005", name: "現金", year: 2020, month: 3, genre: genres[0], amount: 250),
        Sheet(id: "S0006", name: "中信活存", year: 2020, month: 3, genre: genres[1], amount: 200),
        Sheet(id: "S0007", name: "二手中古車", year: 2020, month: 3, genre: genres[9], amount: 400),
        Sheet(id: "S0008", name: "蘆洲三樓公寓", year: 2020, month: 3, genre: genres[10], amount: 1200),
        Sheet(id: "S0009", name: "玉山UBear", year: 2020, month: 2, genre: genres[12], amount: 20),
        Sheet(id: "S0010", name: "二手中古車60期", year: 2020, month: 2, genre: genres[17], amount: 150),
        Sheet(id: "S0011", name: "房貸120期", year: 2020, month: 2, genre: genres[18], amount: 250),
        Sheet(id: "S0012", name: "孝親費", year: 2020, month: 2, genre: genres[14], amount: 500),
        Sheet(id: "S0013", name: "玉山UBear", year: 2020, month: 3, genre: genres[12], amount: 500),
        Sheet(id: "S0014", name: "二手中古車60期", year: 2020, month: 3, genre: genres[17], amount: 150),
        Sheet(id: "S0015", name: "房貸120期", year: 2020, month: 3, genre: genres[18], amount: 500),
        Sheet(id: "S0016", name: "孝親費", year: 2020, month: 3, genre: genres[14], amount: 500000000)
    ]
    
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
                Link(string: "www.flaticon.com", link: "https://www.flaticon.com/")])
    ]
    
    init() {}
}
