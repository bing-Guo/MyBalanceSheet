import UIKit

class RightNumberFieldTableViewCell: UITableViewCell {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var rightTextField: UITextField!
    @IBOutlet weak var leftTextLabel: UILabel!
    
    let numberToolbar: UIToolbar = UIToolbar()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        rightTextField.delegate = self
        rightTextField.keyboardType = .decimalPad
        rightTextField.clearButtonMode = .whileEditing
        rightTextField.text = "0"
        
        numberToolbar.items=[
            UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(cancelButtonTapped)),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "完成", style: .plain, target: self, action: #selector(doneButtonTapped))
        ]

        numberToolbar.sizeToFit()

        rightTextField.inputAccessoryView = numberToolbar
        
        setCell()
    }
    
    func setCell() {
        contentView.backgroundColor = UIColor._standard_light_gray
        container.layer.borderColor = UIColor.white.cgColor
        container.layer.borderWidth = 1
        container.layer.cornerRadius = 8
        clipsToBounds = true
        selectionStyle = .none
    }
    
    func maskTop() {
        layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    @objc func doneButtonTapped () {
        if let text = rightTextField.text {
            let toNumber: Int = Int(text) ?? 0
            rightTextField.text = String(toNumber)
            rightTextField.resignFirstResponder()
        }
    }

    @objc func cancelButtonTapped () {
        rightTextField.text = "0"
        rightTextField.resignFirstResponder()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
}

extension RightNumberFieldTableViewCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowCharacters.isSuperset(of: characterSet)
    }
}
