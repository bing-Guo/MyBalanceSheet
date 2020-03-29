//
//  RightImageTableViewCell.swift
//  MyBalanceSheet
//
//  Created by Bing Guo on 2020/3/29.
//  Copyright © 2020 Bing Guo. All rights reserved.
//

import UIKit

class RightImageTableViewCell: UITableViewCell {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var rightImageView: UIImageView?
    @IBOutlet weak var leftTextLabel: UILabel!
    @IBOutlet weak var SFTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setCell()
        setTextLabel()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCell() {
        contentView.backgroundColor = ._app_background
        container.backgroundColor = .white
        container.layer.borderColor = UIColor.white.cgColor
        container.layer.borderWidth = 1
        container.layer.cornerRadius = 8
        clipsToBounds = true
        selectionStyle = .none
    }
    
    func setTextLabel() {
        SFTextLabel.text = "⟩"
        SFTextLabel.textColor = ._standard_gray
    }
    
    func setup(leftLabelString: String) {
        self.leftTextLabel.text = leftLabelString
    }
    
    func setImage(_ image: UIImage) {
        self.rightImageView?.image = image
    }

}
