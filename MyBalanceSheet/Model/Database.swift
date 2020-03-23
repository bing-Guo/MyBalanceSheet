//
//  Database.swift
//  MyBalanceSheet
//
//  Created by Bing Guo on 2020/3/14.
//  Copyright © 2020 Bing Guo. All rights reserved.
//

import Foundation

class Database {
    static var genres: [Genre] = [
        Genre(id: "0001", mainGenre: "資產", subGenre: "current", accountName: "現金"),
        Genre(id: "0002", mainGenre: "資產", subGenre: "current", accountName: "活存"),
        Genre(id: "0003", mainGenre: "資產", subGenre: "fixed", accountName: "汽車")
    ]
    
    static var sheets: [Sheet] = [
        Sheet(date: "2020/03", genre: genres[0], value: 2000),
        Sheet(date: "2020/03", genre: genres[1], value: 15000)
    ]
    
    init() {}
}
