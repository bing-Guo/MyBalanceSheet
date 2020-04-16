import UIKit

class IconCollectionViewCell: UICollectionViewCell {

    @IBOutlet var iconContainer: UIView!
    @IBOutlet var iconImage: UIImageView!
    var iconString: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setCell()
    }

    func setCell() {
        contentView.backgroundColor = ._app_background
        iconContainer.layer.cornerRadius = 8
        iconContainer.clipsToBounds = true
        iconContainer.backgroundColor = .white
    }
    
    func setup(iconString: String) {
        iconImage.image = UIImage(named: iconString)
    }
    
    func chosenStatus() {
        iconContainer.backgroundColor = ._standard_gray
    }
    
    func normalStatus() {
        backgroundColor = .white
    }
}
