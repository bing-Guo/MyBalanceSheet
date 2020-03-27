import UIKit

class CreateSheetTableViewController: UITableViewController {
    
    var sheetType: SheetType?
    var editMode: Bool = false
    var editData: SheetListViewModel?
    var choseID: String?
    var choseGenre: SheetGenreListViewModel?
    var choseAmount: Int?
    var choseYear: Int?
    var choseMonth: Int?
    var choseName: String?
    let sheetManager = SheetManager.shareInstance
   
    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigation()
        setTableView()
        if(editMode) { setDefaultData() }
    }
    
    func setNavigation() {
        guard let type = sheetType else { return }
        
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "save"), style: .plain, target: self, action: #selector(saveAssetSheet))
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        let titleMode = (editMode) ? "編輯" : "新增"
        
        switch type {
        case .asset:
            self.title = "\(titleMode)資產"
            self.navigationController?.navigationBar.tintColor = ._asset_text
            break
        case .liability:
            self.title = "\(titleMode)負債"
            self.navigationController?.navigationBar.tintColor = ._liability_text
            break
        }
        
    }
    
    func setTableView() {
        tableView.backgroundColor = UIColor._app_background
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "RightTextTableViewCell", bundle: nil), forCellReuseIdentifier: "RightTextTableViewCell")
        tableView.register(UINib(nibName: "RightNumberFieldTableViewCell", bundle: nil), forCellReuseIdentifier: "RightNumberFieldTableViewCell")
        tableView.register(UINib(nibName: "RightDatePickerTableViewCell", bundle: nil), forCellReuseIdentifier: "RightDatePickerTableViewCell")
        tableView.register(UINib(nibName: "RightTextFieldTableViewCell", bundle: nil), forCellReuseIdentifier: "RightTextFieldTableViewCell")
    }
    
    func setDefaultData() {
        choseID = editData?.id
        choseAmount = editData?.amount
        choseYear = editData?.year
        choseMonth = editData?.month
        choseGenre = editData?.genre
        choseName = editData?.name
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        
        switch row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "RightTextTableViewCell", for: indexPath) as! RightTextTableViewCell
                cell.setup(leftLabelString: "類型", rightLabelString: editData?.genre.accountName ?? "類型")
                
                if let genre = choseGenre {
                    cell.rightTextLabel.text = genre.accountName
                    cell.chosenStatus()
                }
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "RightTextFieldTableViewCell", for: indexPath) as! RightTextFieldTableViewCell
                cell.setup(leftLabelString: "名稱", rightTextFieldValue: editData?.name ?? "")
                cell.delegate = self
                
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "RightDatePickerTableViewCell", for: indexPath) as! RightDatePickerTableViewCell
                cell.leftTextLabel.text = "日期"
                cell.delegate = self
                
                if let year = editData?.year, let month = editData?.month {
                    cell.setup(year: year, month: month)
                }
                
                return cell
            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: "RightTextTableViewCell", for: indexPath) as! RightTextTableViewCell
                cell.setup(leftLabelString: "貨幣", rightLabelString: "貨幣")
                
                return cell
            case 4:
                let cell = tableView.dequeueReusableCell(withIdentifier: "RightNumberFieldTableViewCell", for: indexPath) as! RightNumberFieldTableViewCell
                cell.setup(leftLabelString: "金額", rightTextFieldValue: String(editData?.amount ?? 0))
                cell.delegate = self
                
                return cell
            default:
                break
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let type = sheetType else { return }
        
        let row = indexPath.row
        
        switch row {
            case 0:
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let vc = storyboard.instantiateViewController(withIdentifier: "ItemListPage") as? ItemListTableViewController {
                    vc.delegate = self
                    vc.sheetType = type
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
        let id = choseID ?? "S9999"
        let amount = choseAmount ?? 0
        let year = choseYear ?? Date.getYear()
        let month = choseMonth ?? Date.getMonth()
        
        if let genreVM = choseGenre, let name = choseName {
            let genre = Genre(id: genreVM.id, sheetType: genreVM.sheetType, genreType: genreVM.genreType, accountName: genreVM.accountName)
            let sheet = Sheet(id: id, name: name, year: year, month: month, genre: genre, amount: amount)
            
            if editMode {
                updateSheet(sheet: sheet)
            }else {
                createSheet(sheet: sheet)
            }
            navigationController?.popViewController(animated: true)
        }
        print("id: \(choseID), name: \(choseName), year: \(year), month: \(month), amount: \(choseAmount), genre: \(choseGenre)")
    }
    
    func createSheet(sheet: Sheet) {
        sheetManager.addSheet(sheet: sheet)
    }
    
    func updateSheet(sheet: Sheet) {
        sheetManager.updateSheet(sheetData: sheet)
    }
}

extension CreateSheetTableViewController: ChoseItemDelegate {
    func choseItem(genre: SheetGenreListViewModel) {
        self.choseGenre = genre
        tableView.reloadData()
    }
}

extension CreateSheetTableViewController: RightNumberFieldDelegate {
    func getNumberFieldValue(value: Int) {
        self.choseAmount = value
    }
}

extension CreateSheetTableViewController: RightDatePickerDelegate {
    func getDatePickerValue(year: Int, month: Int) {
        self.choseYear = year
        self.choseMonth = month
    }
}

extension CreateSheetTableViewController: RightTextFieldDelegate {
    func getTextFieldValue(value: String) {
        self.choseName = value
    }
}