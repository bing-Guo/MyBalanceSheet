import UIKit

protocol RightPickerDelegate: NSObject {
    func getPickerValue(value: String)
}

class RightPickerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var leftTextLabel: UILabel!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var container: UIView!
    let segmentValue = ["currenct", "fixed"]
    
    weak var delegate: RightPickerDelegate?
    
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
        
        segment.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: CGFloat(17))], for: .normal)
    }
    
    func setup(leftLabelString: String) {
        self.leftTextLabel.text = leftLabelString
    }
    
    @IBAction func segmentChange(_ sender: UISegmentedControl) {
        let value = segmentValue[sender.selectedSegmentIndex]
        delegate?.getPickerValue(value: value)
    }
}
