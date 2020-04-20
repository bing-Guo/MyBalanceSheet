import UIKit

class SummaryTableViewController: UITableViewController {
    
    @IBOutlet weak var dateSelector: DateSelector!
    
    // MARK: - Private
    
    private var noDataView: UIView?
    private let viewModel: SummaryViewModel = SummaryViewModel()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setTabBar()
        setTableView()
        setDateSelector()
        setNoDataView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let date = dateSelector.getDate()
        viewModel.getSummarySheet(year: Date.getYear(date), month: Date.getMonth(date))
        tableView.reloadData()
    }
    
    // MARK: - View Setting
    
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
        tableView.register(UINib(nibName: "SummaryTableViewCell", bundle: nil), forCellReuseIdentifier: "SummaryTableViewCell")
    }
    
    func setDateSelector() {
        dateSelector.delegate = self
        dateSelector.setYellowMode()
    }
    
    // MARK: - Table View Data Source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.container.count > 0 {
            self.tableView.backgroundView?.isHidden = true
            return viewModel.container.count
        } else {
            self.tableView.backgroundView?.isHidden = false
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryTableViewCell", for: indexPath) as? SummaryTableViewCell,
            let cellType = SummaryCellType(rawValue: indexPath.row),
            let summary = viewModel.container[cellType] else { return UITableViewCell() }
        
        cell.summary = summary
        return cell
    }
    
    // MARK: - Table View Delegate
    
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
    
}

extension SummaryTableViewController: DateSelectorDelegate {
    func prevMonth(year: Int, month: Int) {
        viewModel.getSummarySheet(year: year, month: month)
        tableView.reloadData()
    }
    
    func nextMonth(year: Int, month: Int) {
        viewModel.getSummarySheet(year: year, month: month)
        tableView.reloadData()
    }
}
