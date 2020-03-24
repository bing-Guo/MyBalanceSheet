import UIKit

class RightTextTableViewCell: UITableViewCell {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var leftTextLabel: UILabel!
    @IBOutlet weak var rightTextLabel: UILabel!
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
        contentView.backgroundColor = UIColor._standard_light_gray
        container.backgroundColor = UIColor.white
        container.layer.borderColor = UIColor.white.cgColor
        container.layer.borderWidth = 1
        container.layer.cornerRadius = 8
        clipsToBounds = true
        selectionStyle = .none
    }
    
    func setTextLabel() {
        SFTextLabel.text = "⟩"
        rightTextLabel.textColor = UIColor._standard_gray
        SFTextLabel.textColor = UIColor._standard_gray
    }
    
    func setup(leftLabelString: String, rightLabelString: String) {
        self.rightTextLabel.text = leftLabelString
        self.leftTextLabel.text = rightLabelString
    }

    func chosenStatus() {
        rightTextLabel.textColor = UIColor._standard_black
        SFTextLabel.textColor = UIColor._standard_black
    }
}
