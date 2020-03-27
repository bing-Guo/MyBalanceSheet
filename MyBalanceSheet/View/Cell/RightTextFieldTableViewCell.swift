import UIKit

protocol RightTextFieldDelegate: NSObject {
    func getTextFieldValue(value: String)
}

class RightTextFieldTableViewCell: UITableViewCell {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var leftTextLabel: UILabel!
    @IBOutlet weak var rightTextField: UITextField!
    
    weak var delegate: RightTextFieldDelegate?
    
    let numberToolbar: UIToolbar = UIToolbar()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setTextField()
        setCell()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCell() {
        contentView.backgroundColor = UIColor._app_background
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
        rightTextField.font = UIFont.systemFont(ofSize: CGFloat(17))
        rightTextField.placeholder = "輸入名稱"
        rightTextField.returnKeyType = .done
        rightTextField.addTarget(self, action: #selector(textFieldChange), for: .editingChanged)
    }
    
    func setup(leftLabelString: String, rightTextFieldValue: String = "") {
        self.leftTextLabel.text = leftLabelString
        self.rightTextField.text = rightTextFieldValue
    }
    
    // MARK: - Action
    
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
    
    @objc func textFieldChange() {
        print(rightTextField.text ?? "no")
        delegate?.getTextFieldValue(value: rightTextField.text ?? "")
    }
    
    func focusTextField() {
        rightTextField.becomeFirstResponder()
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
