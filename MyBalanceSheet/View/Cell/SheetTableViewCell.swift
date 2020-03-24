//
//  SummaryTableViewCell.swift
//  MyBalanceSheet
//
//  Created by Bing Guo on 2020/3/7.
//  Copyright © 2020 Bing Guo. All rights reserved.
//

import UIKit

class SheetTableViewCell: UITableViewCell {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setCell()
    }
    
    func setCell() {
        contentView.backgroundColor = UIColor._standard_light_gray
        container.layer.borderColor = UIColor.white.cgColor
        container.layer.borderWidth = 1
        container.layer.cornerRadius = 8
        clipsToBounds = true
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
