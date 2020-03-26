import UIKit

class AssetTableViewController: UITableViewController {

    @IBOutlet weak var dateSelector: DateSelector!
    
    var sheetsData: [SheetListViewModel]?
    var data = [TableSection: [SheetListViewModel]]()
    let sheetManager = SheetManager.shareInstance
    
    enum TableSection: Int {
        case current, fixed
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigation()
        setTabBar()
        setTableView()
        setDateSelector()
        setSwipeGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        sheetsData = sheetManager.getAssetList()
        let date = dateSelector.getDate()
        sortData(year: Date.getYear(date), month: Date.getMonth(date))
        setTabBar()
        tableView.reloadData()
    }
    
    func setNavigation() {
        self.title = "資產"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.app.fill"), style: .plain, target: self, action: #selector(createSheet))

        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor._asset_background
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor._asset_text]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor._asset_text]
        self.navigationController?.navigationBar.standardAppearance = navBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        self.navigationController?.navigationBar.tintColor = UIColor._asset_text
    }
    
    func setTabBar() {
        self.tabBarController?.tabBar.tintColor = UIColor._asset_background
    }
    
    func setTableView() {
        tableView.backgroundColor = UIColor._app_background
        tableView.register(UINib(nibName: "SheetTableViewCell", bundle: nil), forCellReuseIdentifier: "SheetTableViewCell")
        tableView.register(UINib(nibName: "SeparateTableViewCell", bundle: nil), forCellReuseIdentifier: "SeparateTableViewCell")
    }
    
    func setSwipeGesture() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swipe(_:)))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swipe(_:)))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    func setDateSelector() {
        dateSelector.delegate = self
        dateSelector.setGreenMode()
    }
    
    func sortData(year: Int, month: Int) {
        guard var filterSheetData = sheetsData else { return }
        
        filterSheetData = filterSheetData.filter( {$0.year == year && $0.month == month } )
        data[.fixed] = filterSheetData.filter( {$0.genre.subGenre == "fixed"} )
        data[.current] = filterSheetData.filter( {$0.genre.subGenre == "current"} )
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tableSection = TableSection(rawValue: section), let sheets = data[tableSection] {
            return sheets.count
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        
        guard let tableSection = TableSection(rawValue: section), let sheetData = data[tableSection]  else { return UITableViewCell() }

        if sheetData.count > 0 {
            let sheet = sheetData[row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "SheetTableViewCell", for: indexPath) as! SheetTableViewCell
            
            cell.setup(genre: sheet.genre.accountName,
                       total: sheet.amountString,
                       status: sheet.rateString)
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let tableSection = TableSection(rawValue: section), let sheets = data[tableSection] else { return "" }
        guard sheets.count > 0 else { return "" }
        
        switch tableSection {
        case .current:
            return "流動資產"
        case .fixed:
            return "固定資產"
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = CellHeaderView(frame: CGRect(x: 10, y: 20, width: tableView.frame.size.width, height: 20))
        headerView.titleLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        return headerView
    }
    
    
    // MARK: - Action
    
    @objc func createSheet(_ sender: Any) {
        self.navigationController?.pushViewController(CreateAssetSheetTableViewController(), animated: false)
    }
    
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

extension AssetTableViewController: DateSelectorDelegate {
    func prevMonth(year: Int, month: Int) {
        sortData(year: year, month: month)
        tableView.reloadData()
    }
    
    func nextMonth(year: Int, month: Int) {
        sortData(year: year, month: month)
        tableView.reloadData()
    }
}
