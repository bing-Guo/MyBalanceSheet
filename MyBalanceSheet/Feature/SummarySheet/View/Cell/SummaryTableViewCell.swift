import UIKit

class SummaryTableViewCell: UITableViewCell {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var rateStateImageView: UIImageView!
    var summary: SummaryCellViewModel! {
        didSet {
            self.genreLabel.text = summary.cellTypeName
            self.totalLabel.text = summary.amountString
            self.statusLabel.text = summary.rateString
            self.statusLabel.textColor = summary.textColor
            self.rateStateImageView.tintColor = summary.textColor
            
            if let icon = summary.rateStateIcon {
                self.rateStateImageView.image = icon
                self.rateStateImageView.isHidden = false
            } else {
                self.rateStateImageView.isHidden = true
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.backgroundColor = UIColor._app_background
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
