import UIKit

protocol ChoseItemDelegate: NSObject {
    func choseItem(genre: Genre)
}

class AssetGenreTableViewController: UITableViewController {
    
    @IBOutlet weak var btnContainer: UIView!
    @IBOutlet weak var createAssetSheetItemBtn: UIButton!
    
    var genreData: [Genre] = Database.assetGenres
    var data = [TableSection: [Genre]]()
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
        genreData = Database.assetGenres
        sortData()
        
        print("reload: \(genreData)")
        print("reload: \(data)")
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
        data[.fixed] = genreData.filter({ $0.subGenre == "fixed" })
        data[.current] = genreData.filter({ $0.subGenre == "current" })
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
            cell.itemLabel.text = genre.accountName
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
    @IBAction func toCreateAssetSheetItemPage(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "CreateAssetItemPage") as? CreateAssetSheetGenreTableViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            fatalError("page not found")
        }
    }
}
