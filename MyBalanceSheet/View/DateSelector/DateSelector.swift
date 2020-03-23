import UIKit

class DateSelector: UIView {

    @IBOutlet var view: UIView!
    @IBOutlet weak var selectorBackgroundView: UIView!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    
    var color: UIColor = UIColor._standard_gray
    
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
}
