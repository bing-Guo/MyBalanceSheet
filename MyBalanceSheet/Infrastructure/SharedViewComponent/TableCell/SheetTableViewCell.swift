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
    @IBOutlet weak var rateStateImageView: UIImageView!
    
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
    
    func setup(genre: String, amount: String, rate: String, rateState: RateState, reverse: Bool = false) {
        self.genreLabel.text = genre
        self.totalLabel.text = amount
        self.statusLabel.text = rate
        setRateState(rateState: rateState, reverse: reverse)
    }
    
    func setRateState(rateState: RateState, reverse: Bool) {
        self.statusLabel.textColor = .black
        rateStateImageView.isHidden = false
        
        switch rateState {
        case .up:
            rateStateImageView.image = UIImage(systemName: "arrowtriangle.up.fill")
            if reverse {
                setDangerColor()
            } else {
                setBetterColor()
            }
            break
        case .down:
            rateStateImageView.image = UIImage(systemName: "arrowtriangle.down.fill")
            if reverse {
                setBetterColor()
            } else {
                setDangerColor()
            }
            break
        case .flat:
            rateStateImageView.image = UIImage(systemName: "minus")
            setFlatColor()
            break
        case .none:
            rateStateImageView.isHidden = true
            break
        }
    }
    
    func setBetterColor() {
        self.statusLabel.textColor = ._asset_background
        rateStateImageView.tintColor = ._asset_background
    }
 
    func setDangerColor() {
        self.statusLabel.textColor = ._liability_background
        rateStateImageView.tintColor = ._liability_background
    }
    
    func setFlatColor() {
        self.statusLabel.textColor = .black
        rateStateImageView.tintColor = .black
    }
    
    func setErrorStatus() {
        let errorView = CellHeaderView()
        addSubview(errorView)
    }
}
