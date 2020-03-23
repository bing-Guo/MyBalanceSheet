//
//  Item.swift
//  MyBalanceSheet
//
//  Created by Bing Guo on 2020/3/14.
//  Copyright © 2020 Bing Guo. All rights reserved.
//

import Foundation

struct Genre: GenreDisplay {
    let id: String
    let mainGenre: String
    let subGenre: String
    let accountName: String
    
    init(id: String, mainGenre: String, subGenre: String, accountName: String) {
        self.id = id
        self.mainGenre = mainGenre
        self.subGenre = subGenre
        self.accountName = accountName
    }
}

protocol GenreDisplay {
    
}

struct GenreSectionName: GenreDisplay {
    let sectionName: String
    
    init(sectionName: String) {
        self.sectionName = sectionName
    }
}

struct GenreCreateSection: GenreDisplay {}
