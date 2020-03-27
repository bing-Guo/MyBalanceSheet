import UIKit

protocol ChoseItemDelegate: NSObject {
    func choseItem(genre: SheetGenreListViewModel)
}

class ItemListTableViewController: UITableViewController {
    
    @IBOutlet weak var btnContainer: UIView!
    @IBOutlet weak var createAssetSheetItemBtn: UIButton!
    
    var sheetType: SheetType?
    var genreData: [SheetGenreListViewModel]?
    var data = [GenreType: [SheetGenreListViewModel]]()
    let genreManager = GenreManager()
    weak var delegate: ChoseItemDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigation()
        setTableView()
        sortData()
        setBtn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        genreData = getData()
        sortData()
        
        tableView.reloadData()
    }
    
    func setNavigation() {
        guard let type = sheetType else { return }
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        switch type {
        case .asset:
            self.title = "資產項目列表"
            break
        case .liability:
            self.title = "負債項目列表"
            break
        }
        
    }
    
    func setTableView() {
        tableView.backgroundColor = UIColor._app_background
        tableView.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ItemTableViewCell")
        tableView.register(UINib(nibName: "CreateItemTableViewCell", bundle: nil), forCellReuseIdentifier: "CreateItemTableViewCell")
    }
    
    func setBtn() {
        guard let type = sheetType else { return }
        
        let btnImage = UIImage(systemName: "plus.circle.fill")
        btnContainer.backgroundColor = UIColor._app_background
        createAssetSheetItemBtn.layer.cornerRadius = 8
        
        switch type {
        case .asset:
            createAssetSheetItemBtn.setTitle("新增資產項目", for: .normal)
            createAssetSheetItemBtn.setImage(btnImage, for: .normal)
            createAssetSheetItemBtn.tintColor = ._asset_background
        case .liability:
            createAssetSheetItemBtn.setTitle("新增負債項目", for: .normal)
            createAssetSheetItemBtn.setImage(btnImage, for: .normal)
            createAssetSheetItemBtn.tintColor = ._liability_background
        }
    }
    
    func getData() -> [SheetGenreListViewModel] {
        guard let type = sheetType else { fatalError() }
        
        switch type {
        case .asset:
            return genreManager.getAssetGenreList()
        case .liability:
            return genreManager.getLiabilityGenreList()
        }
    }
    
    func sortData() {
        guard let filterGenreData = genreData else { return }
        
        data[.fixed] = filterGenreData.filter({ $0.genreType == .fixed })
        data[.current] = filterGenreData.filter({ $0.genreType == .current })
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tableSection = GenreType(rawValue: section), let genre = data[tableSection] {
            return genre.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        
        if let tableSection = GenreType(rawValue: section), let genre = data[tableSection]?[row] {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath) as! ItemTableViewCell
            cell.setup(itemLabelString: genre.accountName)
            return cell
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        let row = indexPath.row
        
        if let tableSection = GenreType(rawValue: section), let genre = data[tableSection]?[row], let d = delegate {
            d.choseItem(genre: genre)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let tableSection = GenreType(rawValue: section), let type = sheetType {
            switch tableSection {
            case .current:
                return (type == .asset) ? "流動資產" : "流動負債"
            case .fixed:
                return (type == .asset) ? "固定資產" : "長期負債"
            }
        }
        return ""
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = CellHeaderView(frame: CGRect(x: 10, y: 20, width: tableView.frame.size.width, height: 20))
        headerView.titleLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        return headerView
    }
    
    // MARK: - Action
    @IBAction func toCreateAssetSheetItemPage(_ sender: Any) {
        guard let type = sheetType else { return }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let vc = storyboard.instantiateViewController(withIdentifier: "CreateItemPage") as? CreateItemTableViewController {
            vc.sheetType = type
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            fatalError("page not found")
        }
    }
}