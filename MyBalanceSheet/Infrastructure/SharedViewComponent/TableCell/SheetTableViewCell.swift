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
    @IBOutlet weak var rateStatueImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setCell()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCell() {
        contentView.backgroundColor = UIColor._app_background
        container.layer.borderColor = UIColor.white.cgColor
        container.layer.borderWidth = 1
        container.layer.cornerRadius = 8
        clipsToBounds = true
        selectionStyle = .none
    }
    
    func setup(genre: String, amount: String, rate: String, rateStatue: RateStatue, reverse: Bool = false) {
        self.genreLabel.text = genre
        self.totalLabel.text = amount
        self.statusLabel.text = rate
        setRateStatue(rateStatue: rateStatue, reverse: reverse)
    }
    
    func setRateStatue(rateStatue: RateStatue, reverse: Bool) {
        self.statusLabel.textColor = .black
        rateStatueImageView.isHidden = false
        
        switch rateStatue {
        case .up:
            rateStatueImageView.image = UIImage(systemName: "arrowtriangle.up.fill")
            if reverse {
                setDangerColor()
            } else {
                setBetterColor()
            }
            break
        case .down:
            rateStatueImageView.image = UIImage(systemName: "arrowtriangle.down.fill")
            if reverse {
                setBetterColor()
            } else {
                setDangerColor()
            }
            break
        case .flat:
            rateStatueImageView.image = UIImage(systemName: "minus")
            setFlatColor()
            break
        case .none:
            rateStatueImageView.isHidden = true
            break
        }
    }
    
    func setBetterColor() {
        self.statusLabel.textColor = ._asset_background
        rateStatueImageView.tintColor = ._asset_background
    }
 
    func setDangerColor() {
        self.statusLabel.textColor = ._liability_background
        rateStatueImageView.tintColor = ._liability_background
    }
    
    func setFlatColor() {
        self.statusLabel.textColor = .black
        rateStatueImageView.tintColor = .black
    }
    
    func setErrorStatus() {
        let errorView = CellHeaderView()
        addSubview(errorView)
    }
}
