import UIKit

protocol RightPickerValueDelegate: NSObject {
    func getPickerValue(value: String)
}

class RightPickerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var leftTextLabel: UILabel!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var container: UIView!
    let segmentValue = ["currenct", "fixed"]
    
    weak var delegate: RightPickerValueDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCell() {
        contentView.backgroundColor = UIColor._standard_light_gray
        container.layer.borderColor = UIColor.white.cgColor
        container.layer.borderWidth = 1
        container.layer.cornerRadius = 8
        clipsToBounds = true
        selectionStyle = .none
    }
    
    @IBAction func segmentChange(_ sender: UISegmentedControl) {
        let value = segmentValue[sender.selectedSegmentIndex]
        delegate?.getPickerValue(value: value)
        print("chose segment: \(value)")
    }
}
