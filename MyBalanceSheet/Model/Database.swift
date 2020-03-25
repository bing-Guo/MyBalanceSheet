import Foundation

class Database {
    static var assetGenres: [Genre] = [
        Genre(id: "a0001", mainGenre: "資產", subGenre: "current", accountName: "現金"),
        Genre(id: "a0002", mainGenre: "資產", subGenre: "current", accountName: "活存"),
        Genre(id: "a0003", mainGenre: "資產", subGenre: "fixed", accountName: "汽車"),
        Genre(id: "a0004", mainGenre: "資產", subGenre: "fixed", accountName: "房屋")
    ]
    
    static var liabilityGenres: [Genre] = [
        Genre(id: "b0001", mainGenre: "負債", subGenre: "current", accountName: "信用卡"),
        Genre(id: "b0002", mainGenre: "負債", subGenre: "longterm", accountName: "車貸"),
        Genre(id: "b0003", mainGenre: "負債", subGenre: "longterm", accountName: "房貸"),
        Genre(id: "b0004", mainGenre: "負債", subGenre: "current", accountName: "孝親費")
    ]
    
    static var sheets: [Sheet] = [
        Sheet(year: 2019, month: 12, genre: assetGenres[0], amount: 20),
        Sheet(year: 2020, month: 1, genre: assetGenres[0], amount: 20),
//        Sheet(year: 2020, month: 2, genre: assetGenres[0], amount: 20),
//        Sheet(year: 2020, month: 2, genre: assetGenres[1], amount: 150),
//        Sheet(year: 2020, month: 3, genre: assetGenres[0], amount: 250),
//        Sheet(year: 2020, month: 3, genre: assetGenres[1], amount: 200),
//        Sheet(year: 2020, month: 3, genre: assetGenres[2], amount: 400),
//        Sheet(year: 2020, month: 3, genre: assetGenres[3], amount: 1200),
//        Sheet(year: 2020, month: 2, genre: liabilityGenres[0], amount: 20),
//        Sheet(year: 2020, month: 2, genre: liabilityGenres[1], amount: 150),
//        Sheet(year: 2020, month: 2, genre: liabilityGenres[2], amount: 250),
//        Sheet(year: 2020, month: 2, genre: liabilityGenres[3], amount: 500),
//        Sheet(year: 2020, month: 3, genre: liabilityGenres[0], amount: 500),
//        Sheet(year: 2020, month: 3, genre: liabilityGenres[1], amount: 150),
//        Sheet(year: 2020, month: 3, genre: liabilityGenres[2], amount: 250),
//        Sheet(year: 2020, month: 3, genre: liabilityGenres[3], amount: 50)
    ]
    
    init() {}
}
