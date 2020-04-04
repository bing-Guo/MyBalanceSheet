import UIKit

class CreateSheetTableViewController: UITableViewController {
    
    var sheetType: SheetType?
    var editMode: Bool = false
    var editData: SheetListViewModel?
    var choseID: UUID?
    var choseGenre: SheetGenreListViewModel?
    var choseAmount: Int?
    var choseYear: Int?
    var choseMonth: Int?
    var choseName: String?
    let sheetManager = SheetManager.shareInstance
    let genreManager = GenreManager.shareInstance
   
    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigation()
        setTableView()
        if(editMode) { setDefaultData() }
    }
    
    func setNavigation() {
        guard let type = sheetType else { return }
        
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "save"), style: .plain, target: self, action: #selector(saveSheet))
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
        return 4
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
    @objc func saveSheet() {
        guard validation() else { return }
        
        let id = choseID ?? UUID()
        let amount = choseAmount ?? 0
        let year = choseYear ?? Date.getYear()
        let month = choseMonth ?? Date.getMonth()
        
        if let genreVM = choseGenre, let name = choseName {
            let genre = genreManager.getGenreByID(id: genreVM.id!)
            
            if editMode {
                sheetManager.updateSheet(id: id, name: name, year: year, month: month, genre: genre, amount: amount)
            }else {
                sheetManager.addSheet(name: name, year: year, month: month, genre: genre, amount: amount)
            }
                        
            navigationController?.popViewController(animated: true)
        }
    }
    
    func validation() -> Bool {
        var isValidCount = 0
        
        let genreCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! RightTextTableViewCell
        let nameCell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! RightTextFieldTableViewCell
        
        if choseGenre == nil{
            genreCell.errorStatus()
            isValidCount += 1
        }else{
            genreCell.normalStatus()
        }
        
        if choseName == nil || choseName == ""{
            nameCell.errorStatus()
            isValidCount += 1
        }else{
            nameCell.normalStatus()
        }
        
        return (isValidCount == 0)
    }
}

extension CreateSheetTableViewController: ChoseItemDelegate {
    func choseItem(genre: SheetGenreListViewModel) {
        self.choseGenre = genre
        
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! RightTextTableViewCell
        cell.rightTextLabel.text = genre.accountName
        cell.chosenStatus()
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
    func getTextField(_ field: UITextField) {
        if let text = field.text{
            self.choseName = text
        }
    }
}
