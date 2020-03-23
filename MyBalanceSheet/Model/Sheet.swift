//
//  Sheet.swift
//  MyBalanceSheet
//
//  Created by Bing Guo on 2020/3/14.
//  Copyright © 2020 Bing Guo. All rights reserved.
//

import Foundation

struct Sheet {
    let date: String
    let genre: Genre
    let value: Int
    
    init(date: String, genre: Genre, value: Int) {
        self.date = date
        self.genre = genre
        self.value = value
    }
}

