import UIKit

class RightTextTableViewCell: UITableViewCell {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var leftTextLabel: UILabel!
    @IBOutlet weak var rightTextLabel: UILabel!
    @IBOutlet weak var SFTextLabel: UILabel!
    @IBOutlet weak var errorContainer: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setCell()
        setTextLabel()
        setErrorView()
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
        rightTextLabel.textColor = ._standard_gray
        SFTextLabel.textColor = ._standard_gray
    }
    
    func setErrorView() {
        errorContainer.backgroundColor = ._liability_background
        errorContainer.layer.cornerRadius = 8
        errorContainer.clipsToBounds = true
        errorLabel.textColor = .white
        errorContainer.isHidden = true
    }
    
    func setup(leftLabelString: String, rightLabelString: String) {
        self.leftTextLabel.text = leftLabelString
        self.rightTextLabel.text = rightLabelString
    }

    func chosenStatus() {
        rightTextLabel.textColor = .black
        SFTextLabel.textColor = .black
    }
    
    func errorStatus() {
        container.layer.borderColor = UIColor._liability_background.cgColor
        container.layer.borderWidth = 2
        errorContainer.isHidden = false
    }
    
    func normalStatus() {
        container.layer.borderWidth = 0
        errorContainer.isHidden = true
    }
}
