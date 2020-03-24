import UIKit

protocol ChoseItemDelegate: NSObject {
    func choseItem(genre: AssetGenreListViewModel)
}

class AssetGenreTableViewController: UITableViewController {
    
    @IBOutlet weak var btnContainer: UIView!
    @IBOutlet weak var createAssetSheetItemBtn: UIButton!
    
    var genreData: [AssetGenreListViewModel]?
    var data = [TableSection: [AssetGenreListViewModel]]()
    let genreManager = GenreManager()
    weak var delegate: ChoseItemDelegate?
    
    enum TableSection: Int {
        case current, fixed
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
        sortData()
        setBtn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        genreData = genreManager.getAssetGenreList()
        sortData()
        
        tableView.reloadData()
    }
    
    func setTableView() {
        tableView.backgroundColor = UIColor._standard_light_gray
        tableView.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ItemTableViewCell")
        tableView.register(UINib(nibName: "CreateItemTableViewCell", bundle: nil), forCellReuseIdentifier: "CreateItemTableViewCell")
    }
    
    func setBtn() {
        btnContainer.backgroundColor = UIColor._standard_light_gray
        createAssetSheetItemBtn.layer.cornerRadius = 8
    }
    
    func sortData() {
        guard let filterGenreData = genreData else { return }
        
        data[.fixed] = filterGenreData.filter({ $0.subGenre == "fixed" })
        data[.current] = filterGenreData.filter({ $0.subGenre == "current" })
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tableSection = TableSection(rawValue: section), let genre = data[tableSection] {
            return genre.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        
        if let tableSection = TableSection(rawValue: section), let genre = data[tableSection]?[row] {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath) as! ItemTableViewCell
            cell.setup(itemLabelString: genre.accountName)
            return cell
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        let row = indexPath.row
        
        if let tableSection = TableSection(rawValue: section), let genre = data[tableSection]?[row], let d = delegate {
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
        if let tableSection = TableSection(rawValue: section) {
            switch tableSection {
            case .fixed:
                return "流動資產"
            case .current:
                return "固定資產"
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
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "CreateAssetItemPage") as? CreateAssetSheetGenreTableViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            fatalError("page not found")
        }
    }
}
