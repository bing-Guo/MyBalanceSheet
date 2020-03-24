//
//  CellHeaderView.swift
//  MyBalanceSheet
//
//  Created by Bing Guo on 2020/3/24.
//  Copyright © 2020 Bing Guo. All rights reserved.
//

import UIKit

class CellHeaderView: UIView {
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel.frame =  CGRect(x: 10, y: 20, width: frame.width-20, height: 20)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
        
        addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
