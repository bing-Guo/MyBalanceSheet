import UIKit

protocol RightSwitchDelegate: NSObject {
    func getSwitchValue(uiSwitch: UISwitch)
}

class RightSwitchTableViewCell: UITableViewCell {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var leftTextLabel: UILabel!
    @IBOutlet weak var rightSwitch: UISwitch!
    weak var delegate: RightSwitchDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setCell()
        setSwitch()
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
    
    func setup(leftLabelString: String) {
        self.leftTextLabel.text = leftLabelString
    }
    
    func setSwitch() {
        rightSwitch.setOn(false, animated: false)
        rightSwitch.addTarget(self, action: #selector(onChange), for: .valueChanged)
    }
    
    @objc func onChange(_ sender: UISwitch) {
        delegate?.getSwitchValue(uiSwitch: rightSwitch)
    }

}

