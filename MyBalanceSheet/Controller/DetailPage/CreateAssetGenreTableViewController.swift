import UIKit

class CreateItemTableViewController: UITableViewController {
    
    @IBOutlet weak var createBtn: UIBarButtonItem!
    
    var sheetType: SheetType?
    var newGenreType: GenreType?
    var newAccountName: String?
    var newIconString: String = "money-1"
    let genreManager = GenreManager.shareInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigation()
        setTableView()
    }
    
    func setNavigation() {
        guard let type = sheetType else { return }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "save"), style: .plain, target: self, action: #selector(CreateAssetItem))
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        switch type {
        case .asset:
            self.title = "新增資產項目"
            break
        case .liability:
            self.title = "新增負債項目"
            break
        }
    }
    
    func setTableView() {
        tableView.backgroundColor = UIColor._app_background
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "RightTextFieldTableViewCell", bundle: nil), forCellReuseIdentifier: "RightTextFieldTableViewCell")
        tableView.register(UINib(nibName: "RightPickerTableViewCell", bundle: nil), forCellReuseIdentifier: "RightPickerTableViewCell")
        tableView.register(UINib(nibName: "RightImageTableViewCell", bundle: nil), forCellReuseIdentifier: "RightImageTableViewCell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let type = sheetType else { fatalError() }
        let row = indexPath.row
        
        switch row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RightTextFieldTableViewCell", for: indexPath) as! RightTextFieldTableViewCell
            cell.setup(leftLabelString: "名稱")
            cell.focusTextField()
            cell.delegate = self
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RightPickerTableViewCell", for: indexPath) as! RightPickerTableViewCell
            let item0 = "流動"
            let item1 = (type == .asset) ? "固定" : "長期"
            
            cell.setup(leftLabelString: "類型")
            cell.segment.setTitle(item0, forSegmentAt: 0)
            cell.segment.setTitle(item1, forSegmentAt: 1)
            cell.delegate = self
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RightImageTableViewCell", for: indexPath) as! RightImageTableViewCell
            
            cell.setup(leftLabelString: "圖式")
            if let image = UIImage(named: newIconString){
                cell.setImage(image)
            }
            return cell
        default:
            break
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard sheetType != nil else { return }
        
        switch indexPath.row {
        case 2:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let vc = storyboard.instantiateViewController(withIdentifier: "choseIconPage") as? IconCollectionViewController {
                vc.delegate = self
                vc.chosenIcon = newIconString
                self.navigationController?.pushViewController(vc, animated: true)
            }
        default:
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    // MARK: - Action
    @objc func CreateAssetItem(_ sender: Any) {
        let genreType = newGenreType ?? .current
        
        if let accountName = newAccountName {
            addAssetItem(genreType: genreType, accountName: accountName)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func addAssetItem(genreType: GenreType, accountName: String) {
        guard let type = sheetType else { return }
        
        genreManager.addGenre(accountName: accountName, genreType: genreType, icon: newIconString, sheetType: type)
    }
}

extension CreateItemTableViewController: RightTextFieldDelegate {
    func getTextField(_ field: UITextField) {
        if let text = field.text{
            newAccountName = text
        }
    }
}

extension CreateItemTableViewController: RightPickerDelegate {
    func getPickerValue(value: GenreType) {
        newGenreType = value
    }
}

extension CreateItemTableViewController: ChoseIconDelegate {
    func choseIcon(iconString: String) {
        newIconString = iconString
        
        let cell = tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as! RightImageTableViewCell
        if let image = UIImage(named: newIconString){
            cell.setImage(image)
        }
    }
}
