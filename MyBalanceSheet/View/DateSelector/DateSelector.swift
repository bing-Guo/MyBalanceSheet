import UIKit

protocol DateSelectorDelegate:NSObject {
    func prevMonth()
    func nextMonth()
}

protocol DataSelectorDataSource {
    
}

class DateSelector: UIView {

    @IBOutlet var view: UIView!
    @IBOutlet weak var selectorBackgroundView: UIView!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    
    var color: UIColor = UIColor._standard_gray
    private var date = Date()
    
    weak var delegate: DateSelectorDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        view = self.loadViewFromNib()
        addSubview(view)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        view = self.loadViewFromNib()
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "DateSelector", bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        setView()
        setButton()
        setSelectorBackgroundView()
        setDateLabel()
        
        return nibView
    }
    
    func setView() {
        view.backgroundColor = UIColor._standard_light_gray
    }
    
    func setButton() {
        leftButton.tintColor = color
        rightButton.tintColor = color
    }
    
    func setSelectorBackgroundView() {
        selectorBackgroundView.layer.cornerRadius = 8
        selectorBackgroundView.backgroundColor = color
    }
    
    func setDateLabel() {
        dateLabel.text = dateToYearMonth(date: date)
    }
    
    // MARK: - Action
    @IBAction func prevBtnAction(_ sender: Any) {
        addMonth(-1)
        setDateLabel()
        delegate?.prevMonth()
    }
    
    @IBAction func nextBtnAction(_ sender: Any) {
        addMonth(1)
        setDateLabel()
        delegate?.nextMonth()
    }
    
    // MARK: - Helper
    func dateToYearMonth(date: Date, formate: String = "yyyy年MM月") -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = formate
        return formatter.string(from: date)
    }
    
    func addMonth(_ value: Int){
        date = Calendar.current.date(byAdding: .month, value: value, to: date)!
    }
    
    func getDate() -> Date {
        return date
    }
    
}
