import UIKit

class SummaryTableViewController: UITableViewController {
    
    @IBOutlet weak var dateSelector: DateSelector!
    
    var noDataView: UIView?
    var summaryData: [SummaryModelView]?
    var data = [SummaryModelView]()
    let sheetManager = SheetManager.shareInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setTabBar()
        setTableView()
        setDateSelector()
        setNoDataView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        summaryData = sheetManager.getSummaryList()
        let date = dateSelector.getDate()
        sortData(year: Date.getYear(date), month: Date.getMonth(date))
        tableView.reloadData()
    }
    
    func setNavigation() {
        self.title = "總覽"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.tintColor = UIColor._summary_text
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor._summary_background
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor._summary_text]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor._summary_text]
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    func setNoDataView() {
        noDataView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: self.tableView.frame.height))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 350, height: 480))
        imageView.image = UIImage(named: "nodata2")
        noDataView!.addSubview(imageView)
        imageView.center = tableView.center
        
        self.tableView.backgroundView = noDataView
    }
    
    func setTabBar() {
        self.tabBarController?.tabBar.tintColor = ._summary_background
    }
    
    func setTableView() {
        tableView.backgroundColor = UIColor._app_background
        tableView.register(UINib(nibName: "SheetTableViewCell", bundle: nil), forCellReuseIdentifier: "SheetTableViewCell")
    }
    
    func setDateSelector() {
        dateSelector.delegate = self
        dateSelector.setYellowMode()
    }
    
    func sortData(year: Int, month: Int) {
        guard let filterData = summaryData else { return }
        
        data = filterData.filter( {$0.year == year && $0.month == month } )
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if data.count > 0 {
            self.tableView.backgroundView?.isHidden = true
            return data.count
        }else{
            self.tableView.backgroundView?.isHidden = false
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        
        if data.count > 0 {
            let summary = data[row]
            switch data[row].type {
            case .networth:
                let cell = tableView.dequeueReusableCell(withIdentifier: "SheetTableViewCell", for: indexPath) as! SheetTableViewCell
                cell.setup(genre: "淨值總計", amount: summary.amountString, rate: summary.rateString, rateStatue: summary.rateStatue)
                
                return cell
            case .asset:
                let cell = tableView.dequeueReusableCell(withIdentifier: "SheetTableViewCell", for: indexPath) as! SheetTableViewCell
                cell.setup(genre: "資產總計", amount: summary.amountString, rate: summary.rateString, rateStatue: summary.rateStatue)
                print(summary.amountString)
                return cell
            case .liability:
                let cell = tableView.dequeueReusableCell(withIdentifier: "SheetTableViewCell", for: indexPath) as! SheetTableViewCell
                cell.setup(genre: "負債總計", amount: summary.amountString, rate: summary.rateString, rateStatue: summary.rateStatue)
                return cell
            case .debtRatio:
                let cell = tableView.dequeueReusableCell(withIdentifier: "SheetTableViewCell", for: indexPath) as! SheetTableViewCell
                cell.setup(genre: "負債比率", amount: summary.amountString, rate: summary.rateString, rateStatue: summary.rateStatue)
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor._app_background
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    // MARK: - Action
    
    @objc func swipe(_ recognizer:UISwipeGestureRecognizer) {
        switch recognizer.direction {
        case .left:
           dateSelector.triggerRightButtonClick()
           break
        case .right:
           dateSelector.triggerLeftButtonClick()
           break
        default:
           break
        }
    }
}

extension SummaryTableViewController: DateSelectorDelegate {
    func prevMonth(year: Int, month: Int) {
        sortData(year: year, month: month)
        tableView.reloadData()
    }
    
    func nextMonth(year: Int, month: Int) {
        sortData(year: year, month: month)
        tableView.reloadData()
    }
}
