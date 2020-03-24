import UIKit

class AssetTableViewController: UITableViewController {

    var sheets: [Sheet]?
    var data = [TableSection: [Sheet]]()
    
    @IBOutlet weak var createSheetBtn: UIBarButtonItem!
    @IBOutlet weak var dateSelector: DateSelector!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateSelector.delegate = self
        
        setNavigation()
        setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getSheetData()
        sortData()
        tableView.reloadData()
    }
    
    enum TableSection: Int {
        case current, fixed
    }
    
    func setNavigation() {
        self.title = "資產"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor._bootstrap_green
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    func setTableView() {
        tableView.backgroundColor = UIColor._standard_light_gray
        tableView.register(UINib(nibName: "SheetTableViewCell", bundle: nil), forCellReuseIdentifier: "SheetTableViewCell")
        tableView.register(UINib(nibName: "SeparateTableViewCell", bundle: nil), forCellReuseIdentifier: "SeparateTableViewCell")
    }
    
    func sortData() {
        guard let sheetsData = sheets else { return }
        
        let date = dateSelector.getDate()
        let yearMonth = dateSelector.dateToYearMonth(date: date, formate: "yyyy/MM")
        
        sheets = sheetsData.filter( {$0.date == yearMonth } )
        data[.fixed] = sheets!.filter( {$0.genre.subGenre == "fixed"} )
        data[.current] = sheets!.filter( {$0.genre.subGenre == "current"} )
    }
    
    func getSheetData() {
        sheets = Database.assetSheets
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tableSection = TableSection(rawValue: section), let sheetData = data[tableSection] {
            return sheetData.count
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = indexPath.section
        let row = indexPath.row
        
        guard let tableSection = TableSection(rawValue: section) else { return UITableViewCell() }
        guard let sheetData = data[tableSection] else { return UITableViewCell() }
        
        if sheetData.count > 0 {
            let sheet = sheetData[row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "SheetTableViewCell", for: indexPath) as! SheetTableViewCell
                
            cell.genreLabel.text = sheet.genre.accountName
            cell.totalLabel.text = String(sheet.amount)
            return cell
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        guard let tableSection = TableSection(rawValue: section) else { return "" }
        
        if data[tableSection]?.count == 0 { return "" }
        
        switch tableSection {
        case .fixed:
            return "流動資產"
        case .current:
            return "固定資產"
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerFrame = tableView.frame

        let title = UILabel()
        title.frame =  CGRect(x: 10, y: 20, width: headerFrame.size.width-20, height: 20)
        title.font = UIFont.boldSystemFont(ofSize: 17.0)
        title.text = self.tableView(tableView, titleForHeaderInSection: section)

        let headerView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: headerFrame.size.width, height: headerFrame.size.height))
        headerView.addSubview(title)

        return headerView
    }
    
    
    // MARK: - Action
    
    @IBAction func createSheet(_ sender: Any) {
        self.navigationController?.pushViewController(CreateAssetSheetTableViewController(), animated: false)
    }
}

extension AssetTableViewController: DateSelectorDelegate {
    func prevMonth() {
        getSheetData()
        sortData()
        tableView.reloadData()
    }
    
    func nextMonth() {
        getSheetData()
        sortData()
        tableView.reloadData()
    }
}
