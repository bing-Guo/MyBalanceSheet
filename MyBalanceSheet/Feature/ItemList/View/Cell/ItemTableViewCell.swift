import UIKit

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var iconContainer: UIView!
    
    var genre: ItemCellViewModel! {
        didSet {
            self.itemLabel.text = genre.accountName
            self.iconImage.image = UIImage(named: genre.icon)
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
        iconContainer.backgroundColor = .none
        iconContainer.layer.cornerRadius = 12
        iconContainer.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
