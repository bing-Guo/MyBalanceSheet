import UIKit

class SheetTableViewController: UITableViewController {

    @IBOutlet weak var dateSelector: DateSelector!
    
    // MARK: - Private
    
    private var noDataView: UIView?
    var sheetType: SheetType?
    private let viewModel: SheetViewModel = SheetViewModel()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        viewModel.sheetType = sheetType
        
        setNavigation()
        setTabBar()
        setTableView()
        setDateSelector()
        setNoDataView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let date = dateSelector.getDate()
        viewModel.getSheetList(year: Date.getYear(date), month: Date.getMonth(date))
        print(viewModel.container)
        tableView.reloadData()
    }
    
    // MARK: - View Setting
    
    func setNavigation() {
        self.title = viewModel.titleString

        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = viewModel.color
        navBarAppearance.titleTextAttributes = [.foregroundColor: viewModel.textColor]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: viewModel.textColor]
        self.navigationController?.navigationBar.standardAppearance = navBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        self.navigationController?.navigationBar.tintColor = viewModel.textColor
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.app.fill"), style: .plain, target: self, action: #selector(createSheet))
    }
    
    func setTabBar() {
        self.tabBarController?.tabBar.tintColor = viewModel.color
    }
    
    func setTableView() {
        tableView.backgroundColor = ._app_background
        tableView.register(UINib(nibName: "SheetTableViewCell", bundle: nil), forCellReuseIdentifier: "SheetTableViewCell")
    }
    
    func setDateSelector() {
        dateSelector.delegate = self
        if sheetType == .asset {
            dateSelector.setGreenMode()
        } else {
            dateSelector.setRedMode()
        }
    }
    
    func setNoDataView() {
        noDataView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: self.tableView.frame.height))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 350, height: 480))
        imageView.image = UIImage(named: "nodata")
        noDataView!.addSubview(imageView)
        imageView.center = tableView.center
        
        self.tableView.backgroundView = noDataView
    }
    
    // MARK: - Table View Data Source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sectionCount
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let tableSection = GenreType(rawValue: section), let sheets = viewModel.sortData[tableSection] else { return 0 }
        
        if viewModel.container.count > 0 {
            self.tableView.backgroundView?.isHidden = true
            return sheets.count
        } else {
            self.tableView.backgroundView?.isHidden = false
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SheetTableViewCell", for: indexPath) as? SheetTableViewCell,
            let tableSection = GenreType(rawValue: indexPath.section),
            let sheetData = viewModel.sortData[tableSection] else { return UITableViewCell() }
        
        cell.sheet = sheetData[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let tableSection = GenreType(rawValue: section) else { return "" }
        return viewModel.sectionTitle[tableSection]
    }
    
    // MARK: - Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let tableSection = GenreType(rawValue: indexPath.section),
            let sheetData = viewModel.sortData[tableSection]?[indexPath.row],
            let type = sheetType else { return }
        
        let storyboard = UIStoryboard(name: "SheetManagement", bundle: nil)
        
        if let vc = storyboard.instantiateViewController(withIdentifier: "SheetManagement") as? CreateSheetTableViewController {
            vc.editData = sheetData
            vc.editMode = true
            vc.sheetType = type
            self.navigationController?.pushViewController(vc, animated: true)
        }
            
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let tableSection = GenreType(rawValue: indexPath.section), let sheetData = viewModel.sortData[tableSection]?[indexPath.row]  else { fatalError() }
        
        let deleteAction = UIContextualAction(style: .normal, title: "") { (action, sourceView, completionHandler) in
            self.deleteSheet(sheetVM: sheetData)
            completionHandler(true)
        }
        
        deleteAction.backgroundColor = ._app_background
        deleteAction.image = UIImage(named: "deleteBtn")

        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
        swipeConfiguration.performsFirstActionWithFullSwipe = false

        return swipeConfiguration
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let tableSection = GenreType(rawValue: section), let sheets = viewModel.sortData[tableSection] else { return 0 }
        guard sheets.count > 0 else { return 0 }
        return 40
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = CellHeaderView(frame: CGRect(x: 10, y: 20, width: tableView.frame.size.width, height: 20))
        headerView.titleLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        return headerView
    }
    
    // MARK: - Action
    
    @objc func createSheet(_ sender: Any) {
        guard let type = sheetType else { return }
        let storyboard = UIStoryboard(name: "SheetManagement", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "SheetManagement") as? CreateSheetTableViewController {
            vc.sheetType = type
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func deleteSheet(sheetVM: SheetCellViewModel) {
        let date = dateSelector.getDate()
        
        viewModel.delete(id: sheetVM.id!)
        viewModel.getSheetList(year: Date.getYear(date), month: Date.getMonth(date))
        tableView.reloadData()
    }
}

extension SheetTableViewController: DateSelectorDelegate {
    func prevMonth(year: Int, month: Int) {
        viewModel.getSheetList(year: year, month: month)
        tableView.reloadData()
    }
    
    func nextMonth(year: Int, month: Int) {
        viewModel.getSheetList(year: year, month: month)
        tableView.reloadData()
    }
}
