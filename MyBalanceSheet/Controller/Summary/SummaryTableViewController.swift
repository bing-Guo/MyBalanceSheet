import UIKit

class SummaryTableViewController: UITableViewController {
    
    @IBOutlet weak var dateSelector: DateSelector!
    
    let sheetManager = SheetManager.shareInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dateSelector.delegate = self
        
        setNavigation()
        setTableView()
        
        let r = sheetManager.getSummaryList()
    }
    
    func setNavigation() {
        self.title = "總覽"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor._bootstrap_yellow
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    func setTableView() {
        tableView.backgroundColor = UIColor._standard_light_gray
        tableView.register(UINib(nibName: "SheetTableViewCell", bundle: nil), forCellReuseIdentifier: "SheetTableViewCell")
    }
    
    func sortData(year: Int, month: Int) {
//        guard var filterSheetData = sheetsData else { return }
//
//        filterSheetData = filterSheetData.filter( {$0.year == year && $0.month == month } )
//        data[.longterm] = filterSheetData.filter( {$0.genre.subGenre == "longterm"} )
//        data[.current] = filterSheetData.filter( {$0.genre.subGenre == "current"} )
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "SheetTableViewCell", for: indexPath) as! SheetTableViewCell
        
        switch row {
        case 0:
            cell.setup(genre: "淨值總計", total: "0", status: "")
            return cell
        case 1:
            cell.setup(genre: "資產總計", total: "0", status: "")
            return cell
        case 2:
            cell.setup(genre: "負債總計", total: "0", status: "")
            return cell
        case 3:
            cell.setup(genre: "負債比率", total: "0", status: "")
            return cell
        default:
            break
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor._standard_light_gray
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
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
