import UIKit

protocol RightTextFieldDelegate: NSObject {
    func getTextField(_ field: UITextField)
}

class RightTextFieldTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var leftTextLabel: UILabel!
    @IBOutlet weak var rightTextField: UITextField!
    @IBOutlet weak var errorContainer: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    
    weak var delegate: RightTextFieldDelegate?
    
    let numberToolbar: UIToolbar = UIToolbar()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setTextField()
        setCell()
        setErrorView()
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
    
    func setErrorView() {
        errorContainer.backgroundColor = ._liability_background
        errorContainer.layer.cornerRadius = 8
        errorContainer.clipsToBounds = true
        errorLabel.textColor = .white
        errorContainer.isHidden = true
    }
    
    func setup(leftLabelString: String, rightTextFieldValue: String = "") {
        self.leftTextLabel.text = leftLabelString
        self.rightTextField.text = rightTextFieldValue
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
    
    // MARK: - Action
    
    @objc func textFieldChange() {
        delegate?.getTextField(rightTextField)
    }
    
    // MARK: - TextField Delegate
    
    func focusTextField() {
        rightTextField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.getTextField(rightTextField)
        rightTextField.resignFirstResponder()
        return true
    }
}
