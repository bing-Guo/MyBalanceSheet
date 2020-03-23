//
//  RightTextTableViewCell.swift
//  MyBalanceSheet
//
//  Created by Bing Guo on 2020/3/14.
//  Copyright © 2020 Bing Guo. All rights reserved.
//

import UIKit

class RightTextTableViewCell: UITableViewCell {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var leftTextLabel: UILabel!
    @IBOutlet weak var rightTextLabel: UILabel!
    @IBOutlet weak var SFTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        SFTextLabel.text = "⟩"
        rightTextLabel.textColor = UIColor._standard_gray
        SFTextLabel.textColor = UIColor._standard_gray
        
        setCell()
    }
    
    func setCell() {
        contentView.backgroundColor = UIColor._standard_light_gray
        container.backgroundColor = UIColor.white
        container.layer.borderColor = UIColor.white.cgColor
        container.layer.borderWidth = 1
        container.layer.cornerRadius = 8
        clipsToBounds = true
        selectionStyle = .none
    }
    
    func maskButton() {
        layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func chosenStatus() {
        rightTextLabel.textColor = UIColor._standard_black
        SFTextLabel.textColor = UIColor._standard_black
    }
}
