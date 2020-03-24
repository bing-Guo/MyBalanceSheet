//
//  Database.swift
//  MyBalanceSheet
//
//  Created by Bing Guo on 2020/3/14.
//  Copyright © 2020 Bing Guo. All rights reserved.
//

import Foundation

class Database {
    static var assetGenres: [Genre] = [
        Genre(id: "a0001", mainGenre: "資產", subGenre: "current", accountName: "現金"),
        Genre(id: "a0002", mainGenre: "資產", subGenre: "current", accountName: "活存"),
        Genre(id: "a0003", mainGenre: "資產", subGenre: "fixed", accountName: "汽車")
    ]
    
    static var liabilityGenres: [Genre] = [
        Genre(id: "b0001", mainGenre: "負債", subGenre: "current", accountName: "信用卡"),
        Genre(id: "b0002", mainGenre: "負債", subGenre: "long-term", accountName: "車貸")
    ]
    
    static var assetSheets: [Sheet] = [
        Sheet(date: "2020/03", genre: assetGenres[0], amount: 2000),
        Sheet(date: "2020/03", genre: assetGenres[1], amount: 15000)
    ]
    
    init() {}
}
