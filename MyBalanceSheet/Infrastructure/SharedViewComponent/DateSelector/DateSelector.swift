import UIKit

protocol DateSelectorDelegate:NSObject {
    func prevMonth(year: Int, month: Int)
    func nextMonth(year: Int, month: Int)
}

class DateSelector: UIView {

    @IBOutlet var view: UIView!
    @IBOutlet weak var selectorBackgroundView: UIView!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    
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
        setButton(UIColor._standard_gray)
        setSelectorBackgroundView(UIColor._standard_gray)
        setDateLabel()
        
        return nibView
    }
    
    func setView() {
        view.backgroundColor = UIColor._app_background
    }
    
    func setButton(_ color: UIColor) {
        leftButton.tintColor = color
        rightButton.tintColor = color
    }
    
    func setSelectorBackgroundView(_ color: UIColor) {
        selectorBackgroundView.layer.cornerRadius = 8
        selectorBackgroundView.backgroundColor = color
    }
    
    func setDateLabel() {
        dateLabel.text = dateToYearMonth(date: date)
        dateLabel.font = UIFont.boldSystemFont(ofSize: CGFloat(17))
    }
    
    // MARK: - Action
    @IBAction func prevBtnAction(_ sender: Any) {
        addMonth(-1)
        setDateLabel()
        delegate?.prevMonth(year: Date.getYear(date), month: Date.getMonth(date))
    }
    
    @IBAction func nextBtnAction(_ sender: Any) {
        addMonth(1)
        setDateLabel()
        delegate?.nextMonth(year: Date.getYear(date), month: Date.getMonth(date))
    }
    
    func setGreenMode() {
        let color: UIColor = UIColor._asset_background
        setSelectorBackgroundView(color)
        setButton(color)
        dateLabel.textColor = UIColor._asset_text
    }
    
    func setYellowMode() {
        let color: UIColor = UIColor._summary_background
        setSelectorBackgroundView(color)
        setButton(color)
        dateLabel.textColor = UIColor._summary_text
    }
    
    func setRedMode() {
        let color: UIColor = UIColor._liability_background
        setSelectorBackgroundView(color)
        setButton(color)
        dateLabel.textColor = UIColor._liability_text
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
