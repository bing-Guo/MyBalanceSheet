import UIKit

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var describeLabel: UILabel!
    
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
    
    func setup(itemLabelString: String, describeLabelString: String = "") {
        self.itemLabel.text = itemLabelString
        self.describeLabel.text = describeLabelString
    }
    
}
