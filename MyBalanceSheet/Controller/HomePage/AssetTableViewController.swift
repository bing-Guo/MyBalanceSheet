import UIKit

class AssetTableViewController: UITableViewController {

    @IBOutlet weak var dateSelector: DateSelector!
    
    var sheetsData: [SheetListViewModel]?
    var data = [GenreType: [SheetListViewModel]]()
    let sheetManager = SheetManager.shareInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigation()
        setTabBar()
        setTableView()
        setDateSelector()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let count = fetchData()
        setNoData( (count == 0) )
        
        tableView.reloadData()
    }
    
    func setNavigation() {
        self.title = "資產"
//        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor._asset_background
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor._asset_text]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor._asset_text]
        self.navigationController?.navigationBar.standardAppearance = navBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        self.navigationController?.navigationBar.tintColor = UIColor._asset_text
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.app.fill"), style: .plain, target: self, action: #selector(createSheet))
    }
    
    func setTabBar() {
        self.tabBarController?.tabBar.tintColor = UIColor._asset_background
    }
    
    func setTableView() {
        tableView.backgroundColor = UIColor._app_background
        tableView.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ItemTableViewCell")
    }
    
    func setDateSelector() {
        dateSelector.delegate = self
        dateSelector.setGreenMode()
    }
    
    func fetchData() -> Int {
        sheetsData = sheetManager.getAssetList()
        let date = dateSelector.getDate()
        let filter = filterData(year: Date.getYear(date), month: Date.getMonth(date))
        sortData(filter)
        
        return filter.count
    }
    
    func filterData(year: Int, month: Int) -> [SheetListViewModel] {
        guard var filterSheetData = sheetsData else { return [] }
        filterSheetData = filterSheetData.filter( {$0.year == year && $0.month == month } )
        
        return filterSheetData
    }
    
    func sortData(_ filter: [SheetListViewModel]) {
        data[.fixed] = filter.filter( {$0.genre.genreType == .fixed} )
        data[.current] = filter.filter( {$0.genre.genreType == .current} )
    }

    func setNoData(_ isNoData: Bool) {
        let noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 20 ))
        noDataLabel.text = (isNoData) ? "尚未有紀錄" : ""
        noDataLabel.textAlignment = .center
        
        self.tableView.backgroundView = noDataLabel
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
       return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tableSection = GenreType(rawValue: section), let sheets = data[tableSection] {
            return sheets.count
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        
        guard let tableSection = GenreType(rawValue: section), let sheetData = data[tableSection]  else { return UITableViewCell() }

        if sheetData.count > 0 {
            let sheet = sheetData[row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath) as! ItemTableViewCell
            
            cell.setup(itemLabelString: sheet.name, iconString: sheet.genre.icon, describeLabelString: sheet.amountString)
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let tableSection = GenreType(rawValue: indexPath.section), let sheetData = data[tableSection]?[indexPath.row]  else { return }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let vc = storyboard.instantiateViewController(withIdentifier: "CreateSheetPage") as? CreateSheetTableViewController {
            vc.editData = sheetData
            vc.editMode = true
            vc.sheetType = .asset
            self.navigationController?.pushViewController(vc, animated: true)
        }
            
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let tableSection = GenreType(rawValue: indexPath.section), let sheetData = data[tableSection]?[indexPath.row]  else { fatalError() }
        
        let shareAction = UIContextualAction(style: .normal, title: "") { (action, sourceView, completionHandler) in
            self.deleteSheet(sheetVM: sheetData)
            completionHandler(true)
        }
        
        shareAction.backgroundColor = ._app_background
        shareAction.image = UIImage(named: "deleteBtn")

        let swipeConfiguration = UISwipeActionsConfiguration(actions: [shareAction])
        swipeConfiguration.performsFirstActionWithFullSwipe = false

        return swipeConfiguration
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let tableSection = GenreType(rawValue: section), let sheets = data[tableSection] else { fatalError() }
        guard sheets.count > 0 else { return 0 }
        return 40
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let tableSection = GenreType(rawValue: section), let sheets = data[tableSection] else { return "" }
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
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "CreateSheetPage") as? CreateSheetTableViewController {
            vc.sheetType = .asset
            self.navigationController?.pushViewController(vc, animated: true)
        }
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
    
    func deleteSheet(sheetVM: SheetListViewModel) {
        sheetManager.deleteSheet(id: sheetVM.id!)
        let count = fetchData()
        setNoData( (count == 0) )
        
        tableView.reloadData()
    }
}

extension AssetTableViewController: DateSelectorDelegate {
    func prevMonth(year: Int, month: Int) {
        let filter = filterData(year: year, month: month)
        setNoData( (filter.count == 0) )
        sortData(filter)
        tableView.reloadData()
    }
    
    func nextMonth(year: Int, month: Int) {
        let filter = filterData(year: year, month: month)
        setNoData( (filter.count == 0) )
        sortData(filter)
        tableView.reloadData()
    }
}
