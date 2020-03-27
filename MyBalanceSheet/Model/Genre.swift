//
//  Item.swift
//  MyBalanceSheet
//
//  Created by Bing Guo on 2020/3/14.
//  Copyright © 2020 Bing Guo. All rights reserved.
//

import Foundation

struct Genre {
    let id: String
    let icon: String
    let sheetType: SheetType
    let genreType: GenreType
    let accountName: String
    
    init(id: String, icon: String, sheetType: SheetType, genreType: GenreType, accountName: String) {
        self.id = id
        self.icon = icon
        self.sheetType = sheetType
        self.genreType = genreType
        self.accountName = accountName
    }
}
