import Foundation

class Database {
    static var genres: [Genre] = [
        Genre(id: "a0001", sheetType: .asset, genreType: .current, accountName: "現金"),
        Genre(id: "a0002", sheetType: .asset, genreType: .current, accountName: "活存"),
        Genre(id: "a0003", sheetType: .asset, genreType: .fixed, accountName: "汽車"),
        Genre(id: "a0004", sheetType: .asset, genreType: .fixed, accountName: "房屋"),
        Genre(id: "b0001", sheetType: .liability, genreType: .current, accountName: "信用卡"),
        Genre(id: "b0002", sheetType: .liability, genreType: .fixed, accountName: "車貸"),
        Genre(id: "b0003", sheetType: .liability, genreType: .fixed, accountName: "房貸"),
        Genre(id: "b0004", sheetType: .liability, genreType: .current, accountName: "孝親費")
    ]
    
    static var sheets: [Sheet] = [
        Sheet(id: "S0001", name: "現金", year: 2019, month: 12, genre: genres[0], amount: 20),
        Sheet(id: "S0002", name: "現金", year: 2020, month: 1, genre: genres[0], amount: 20),
        Sheet(id: "S0003", name: "現金", year: 2020, month: 2, genre: genres[0], amount: 20),
        Sheet(id: "S0004", name: "中信活存", year: 2020, month: 2, genre: genres[1], amount: 150),
        Sheet(id: "S0005", name: "現金", year: 2020, month: 3, genre: genres[0], amount: 250),
        Sheet(id: "S0006", name: "中信活存", year: 2020, month: 3, genre: genres[1], amount: 200),
        Sheet(id: "S0007", name: "二手中古車", year: 2020, month: 3, genre: genres[2], amount: 400),
        Sheet(id: "S0008", name: "蘆洲三樓公寓", year: 2020, month: 3, genre: genres[3], amount: 1200),
        Sheet(id: "S0009", name: "玉山UBear", year: 2020, month: 2, genre: genres[4], amount: 20),
        Sheet(id: "S0010", name: "二手中古車60期", year: 2020, month: 2, genre: genres[5], amount: 150),
        Sheet(id: "S0011", name: "房貸120期", year: 2020, month: 2, genre: genres[6], amount: 250),
        Sheet(id: "S0012", name: "孝親費", year: 2020, month: 2, genre: genres[7], amount: 500),
        Sheet(id: "S0013", name: "玉山UBear", year: 2020, month: 3, genre: genres[4], amount: 500),
        Sheet(id: "S0014", name: "二手中古車60期", year: 2020, month: 3, genre: genres[5], amount: 150),
        Sheet(id: "S0015", name: "房貸120期", year: 2020, month: 3, genre: genres[6], amount: 500),
        Sheet(id: "S0016", name: "孝親費", year: 2020, month: 3, genre: genres[7], amount: 500000000)
    ]
    
    init() {}
}
