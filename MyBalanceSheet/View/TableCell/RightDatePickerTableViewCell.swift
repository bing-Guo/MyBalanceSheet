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
    
    private var selectedYear: Int = Date.getYear()
    private var selectedMonth: Int = Date.getMonth()
    var selectedYearMonth: String {
        return String(format: "%d/%02d", selectedYear, selectedMonth)
    }
    
    weak var delegate: RightDatePickerDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setTextField()
        setCell()
        setup()
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
    
    func setup(year: Int = Date.getYear(), month: Int = Date.getMonth() ) {
        self.selectedYear = year
        self.selectedMonth = month
        dateTextField.text = selectedYearMonth
        selectPickerRow(year: year, month: month)
    }
    
    private func selectPickerRow(year: Int, month: Int) {
        let currentYearIndex = 5
        let yearIndex = currentYearIndex - (Date.getYear() - year)
        
        datePickerView?.selectRow(month-1, inComponent: 0, animated: false)
        datePickerView?.selectRow(yearIndex, inComponent: 1, animated: false)
    }
    
    // MARK: - Action
    
    @objc func doneButtonTapped () {
        dateTextField.text = selectedYearMonth
        delegate?.getDatePickerValue(year: selectedYear, month: selectedMonth)
        dateTextField.resignFirstResponder()
    }
}
