import UIKit

class EditAssetSheetTableViewController: UITableViewController {

    var originData: SheetListViewModel?
    var choseGenre: SheetGenreListViewModel?
    var choseAmount: Int?
    var choseYear: Int?
    var choseMonth: Int?
    let sheetManager = SheetManager.shareInstance
   
    override func viewDidLoad() {
        super.viewDidLoad()

        setDefaultData()
        setNavigation()
        setTabBar()
        setTableView()
    }

    func setNavigation() {
        self.title = "編輯資產"
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "save"), style: .plain, target: self, action: #selector(saveAssetSheet))
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.tintColor = ._asset_text
    }
    
    func setTabBar() {
        self.tabBarController?.tabBar.tintColor = UIColor._asset_background
    }
    
    func setTableView() {
        tableView.backgroundColor = UIColor._app_background
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "RightTextTableViewCell", bundle: nil), forCellReuseIdentifier: "RightTextTableViewCell")
        tableView.register(UINib(nibName: "RightNumberFieldTableViewCell", bundle: nil), forCellReuseIdentifier: "RightNumberFieldTableViewCell")
        tableView.register(UINib(nibName: "RightDatePickerTableViewCell", bundle: nil), forCellReuseIdentifier: "RightDatePickerTableViewCell")
    }
    
    func setDefaultData() {
        choseAmount = originData?.amount
        choseYear = originData?.year
        choseMonth = originData?.month
        choseGenre = originData?.genre
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
        
        switch row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "RightTextTableViewCell", for: indexPath) as! RightTextTableViewCell
                cell.setup(leftLabelString: "選擇類型", rightLabelString: originData?.genre.accountName ?? "類型")
                cell.chosenStatus()
                
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "RightDatePickerTableViewCell", for: indexPath) as! RightDatePickerTableViewCell
                cell.leftTextLabel.text = "選擇日期"
                cell.delegate = self
                
                if let year = originData?.year, let month = originData?.month {
                    cell.setup(year: year, month: month)
                }
                
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "RightTextTableViewCell", for: indexPath) as! RightTextTableViewCell
                cell.setup(leftLabelString: "選擇貨幣", rightLabelString: "貨幣")
                
                return cell
            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: "RightNumberFieldTableViewCell", for: indexPath) as! RightNumberFieldTableViewCell
                cell.setup(leftLabelString: "選擇金額", rightTextFieldValue: String(originData?.amount ?? 0))
                cell.delegate = self
                
                return cell
            default:
                break
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        
        switch row {
            case 0:
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let vc = storyboard.instantiateViewController(withIdentifier: "GenreItemPage") as? AssetGenreTableViewController {
                    vc.delegate = self
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
    @objc func saveAssetSheet() {
        let amount = choseAmount ?? 0
        let year = choseYear ?? Date.getYear()
        let month = choseMonth ?? Date.getMonth()
        
        if let genreVM = choseGenre {
            let genre = Genre(id: genreVM.id, mainGenre: genreVM.mainGenre, subGenre: genreVM.subGenre, accountName: genreVM.accountName)
            let sheet = Sheet(year: year, month: month, genre: genre, amount: amount)
            updateSheet(sheet: sheet)
            navigationController?.popViewController(animated: true)
        }
        print("year: \(year), month: \(month), amount: \(choseAmount), genre: \(choseGenre)")
    }
    
    func updateSheet(sheet: Sheet) {
        sheetManager.updateSheet(sheetData: sheet)
    }
    
}

extension EditAssetSheetTableViewController: ChoseItemDelegate {
    func choseItem(genre: SheetGenreListViewModel) {
        self.choseGenre = genre
        if let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? RightTextTableViewCell {
            cell.rightTextLabel.text = genre.accountName
            cell.chosenStatus()
        }
    }
}

extension EditAssetSheetTableViewController: RightNumberFieldDelegate {
    func getNumberFieldValue(value: Int) {
        self.choseAmount = value
    }
}

extension EditAssetSheetTableViewController: RightDatePickerDelegate {
    func getDatePickerValue(year: Int, month: Int) {
        self.choseYear = year
        self.choseMonth = month
    }
}
