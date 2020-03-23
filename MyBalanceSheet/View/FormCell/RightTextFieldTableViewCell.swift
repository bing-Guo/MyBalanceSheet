import UIKit

protocol RightTextFieldValueDelegate: NSObject {
    func getTextFieldValue(value: String)
}

class RightTextFieldTableViewCell: UITableViewCell {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var leftTextLabel: UILabel!
    @IBOutlet weak var rightTextField: UITextField!
    
    weak var delegate: RightTextFieldValueDelegate?
    
    let numberToolbar: UIToolbar = UIToolbar()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setTextField()
        setCell()
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
    
    func setTextField() {
        rightTextField.delegate = self
        rightTextField.clearButtonMode = .whileEditing
        rightTextField.placeholder = "ex.某某銀行"
        rightTextField.returnKeyType = .done
    }
    
    func maskTop() {
        container.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    @objc func doneButtonTapped () {
        if let text = rightTextField.text {
            let toNumber: Int = Int(text) ?? 0
            rightTextField.text = String(toNumber)
            rightTextField.resignFirstResponder()
        }
    }

    @objc func cancelButtonTapped () {
        rightTextField.text = ""
        rightTextField.resignFirstResponder()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension RightTextFieldTableViewCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "\n" {
            delegate?.getTextFieldValue(value: rightTextField.text ?? "")
            rightTextField.resignFirstResponder()
        }
        return true
    }
}
