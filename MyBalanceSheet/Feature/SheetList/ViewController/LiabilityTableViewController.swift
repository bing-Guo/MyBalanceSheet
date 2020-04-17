import UIKit

class LiabilityTableViewController: UITableViewController {
    
    @IBOutlet weak var dateSelector: DateSelector!
    
    // MARK: - Private
    
    private var noDataView: UIView?
    private let viewModel: SheetViewModel = SheetViewModel()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigation()
        setTabBar()
        setTableView()
        setDateSelector()
        setNoDataView()
    }
    
    // MARK: - View Setting
    
    override func viewWillAppear(_ animated: Bool) {
        let date = dateSelector.getDate()
        viewModel.getSheetList(sheetType: .liability, year: Date.getYear(date), month: Date.getMonth(date))
        setNoData( (viewModel.container.count == 0) )
        
        tableView.reloadData()
    }
    
    func setNavigation() {
        self.title = "負債"
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor._liability_background
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor._liability_text]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor._liability_text]
        self.navigationController?.navigationBar.standardAppearance = navBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        self.navigationController?.navigationBar.tintColor = UIColor._liability_text
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.app.fill"), style: .plain, target: self, action: #selector(createSheet))
    }
    
    func setTabBar() {
        self.tabBarController?.tabBar.tintColor = UIColor._liability_background
    }
    
    func setTableView() {
        tableView.backgroundColor = UIColor._app_background
        tableView.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ItemTableViewCell")
    }
    
    func setDateSelector() {
        dateSelector.delegate = self
        dateSelector.setRedMode()
    }
    
    func setNoDataView() {
        noDataView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: self.tableView.frame.height))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 350, height: 480))
        imageView.image = UIImage(named: "nodata")
        noDataView!.addSubview(imageView)
        imageView.center = tableView.center
        
        self.tableView.backgroundView = noDataView
    }
    
    func setNoData(_ isNoData: Bool) {
        self.tableView.backgroundView?.isHidden = !isNoData
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tableSection = GenreType(rawValue: section), let sheets = viewModel.sortData[tableSection] {
            return sheets.count
        }
        
        return 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        
        guard let tableSection = GenreType(rawValue: section), let sheetData = viewModel.sortData[tableSection]  else { return UITableViewCell() }

        if sheetData.count > 0 {
            let sheet = sheetData[row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath) as! ItemTableViewCell
            
            cell.setup(itemLabelString: sheet.name, iconString: sheet.genre.icon, describeLabelString: sheet.amountString)
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let tableSection = GenreType(rawValue: indexPath.section), let sheetData = viewModel.sortData[tableSection]?[indexPath.row]  else { return }
        
        let storyboard = UIStoryboard(name: "SheetManagement", bundle: nil)
        
        if let vc = storyboard.instantiateViewController(withIdentifier: "SheetManagement") as? CreateSheetTableViewController {
            vc.editData = sheetData
            vc.editMode = true
            vc.sheetType = .liability
            self.navigationController?.pushViewController(vc, animated: true)
        }
            
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let tableSection = GenreType(rawValue: indexPath.section), let sheetData = viewModel.sortData[tableSection]?[indexPath.row]  else { fatalError() }
        
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
        return 40
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let tableSection = GenreType(rawValue: section), let sheets = viewModel.sortData[tableSection] else { return "" }
        guard sheets.count > 0 else { return "" }
        
        switch tableSection {
        case .fixed:
            return "長期負債"
        case .current:
            return "流動負債"
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = CellHeaderView(frame: CGRect(x: 10, y: 20, width: tableView.frame.size.width, height: 20))
        headerView.titleLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        return headerView
    }
    
    // MARK: - Action
    
    @objc func createSheet(_ sender: Any) {
        let storyboard = UIStoryboard(name: "SheetManagement", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "SheetManagement") as? CreateSheetTableViewController {
            vc.sheetType = .liability
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func deleteSheet(sheetVM: SheetCellViewModel) {
        viewModel.delete(id: sheetVM.id!)
        setNoData( (viewModel.container.count == 0) )
        
        tableView.reloadData()
    }
}

extension LiabilityTableViewController: DateSelectorDelegate {
    func prevMonth(year: Int, month: Int) {
        viewModel.getSheetList(sheetType: .liability, year: year, month: month)
        setNoData( (viewModel.container.count == 0) )
        tableView.reloadData()
    }
    
    func nextMonth(year: Int, month: Int) {
        viewModel.getSheetList(sheetType: .liability, year: year, month: month)
        setNoData( (viewModel.container.count == 0) )
        tableView.reloadData()
    }
}
