import UIKit

protocol RightDatePickerDelegate: NSObject {
    func getDatePickerValue(year: Int, month: Int)
}

class RightDatePickerTableViewCell: UITableViewCell {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var leftTextLabel: UILabel!
    @IBOutlet weak var dateTextField: UITextField!
    
    private var datePickerView: MonthYearPickerView?
    private var toolbar = UIToolbar()
    
    private var selectedYearMonth: String = String(format: "%d/%02d", Date.getYear(), Date.getMonth())
    private var selectedYear: Int = Date.getYear()
    private var selectedMonth: Int = Date.getMonth()
    
    weak var delegate: RightDatePickerDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setTextField()
        setCell()
        
        dateTextField.text = selectedYearMonth
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
    }
    
    func setTextField() {
        setToolBar()
        setDatePickerView()
        
        dateTextField.inputAccessoryView = toolbar
        dateTextField.inputView = datePickerView
        dateTextField.font = UIFont.systemFont(ofSize: CGFloat(17))
    }
    
    func setDatePickerView() {
        datePickerView = MonthYearPickerView()
        datePickerView?.onDateSelected = { (month: Int, year: Int) in
            self.selectedYearMonth = String(format: "%d/%02d", year, month)
            self.selectedYear = year
            self.selectedMonth = month
        }
    }
    
    func setToolBar() {
        toolbar.items=[
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "完成", style: .plain, target: self, action: #selector(doneButtonTapped))
        ]
        toolbar.sizeToFit()
    }
    
    // MARK: - Action
    
    @objc func doneButtonTapped () {
        dateTextField.text = selectedYearMonth
        delegate?.getDatePickerValue(year: selectedYear, month: selectedMonth)
        dateTextField.resignFirstResponder()
    }
}
