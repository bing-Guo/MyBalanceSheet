import UIKit

class CreateLiabilitySheetTableViewController: UITableViewController {

    var choseGenre: SheetGenreListViewModel?
    let sheetManager = SheetManager.shareInstance
    var choseAmount: Int?
    var choseYear: Int?
    var choseMonth: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigation()
        setTableView()
    }

    func setNavigation() {
        self.title = "新增負債"
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "儲存", style: .plain, target: self, action: #selector(saveLiabilitySheet))
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    func setTableView() {
        tableView.backgroundColor = UIColor._app_background
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "RightTextTableViewCell", bundle: nil), forCellReuseIdentifier: "RightTextTableViewCell")
        tableView.register(UINib(nibName: "RightNumberFieldTableViewCell", bundle: nil), forCellReuseIdentifier: "RightNumberFieldTableViewCell")
        tableView.register(UINib(nibName: "RightDatePickerTableViewCell", bundle: nil), forCellReuseIdentifier: "RightDatePickerTableViewCell")
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
                cell.setup(leftLabelString: "選擇類型", rightLabelString: "類型")
                
                if let genre = choseGenre {
                    cell.rightTextLabel.text = genre.accountName
                    cell.chosenStatus()
                }

                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "RightDatePickerTableViewCell", for: indexPath) as! RightDatePickerTableViewCell
                cell.leftTextLabel.text = "選擇日期"
                cell.delegate = self
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "RightTextTableViewCell", for: indexPath) as! RightTextTableViewCell
                cell.setup(leftLabelString: "選擇貨幣", rightLabelString: "貨幣")
                
                return cell
            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: "RightNumberFieldTableViewCell", for: indexPath) as! RightNumberFieldTableViewCell
                cell.setup(leftLabelString: "選擇金額")
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
                if let vc = storyboard.instantiateViewController(withIdentifier: "LiabilityGenreItemPage") as? LiabilityGenreTableViewController {
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
    @objc func saveLiabilitySheet() {
        let amount = choseAmount ?? 0
        let year = choseYear ?? Date.getYear()
        let month = choseMonth ?? Date.getMonth()
        
        if let genreVM = choseGenre {
            // todo
            let genre = Genre(id: genreVM.id, mainGenre: genreVM.mainGenre, subGenre: genreVM.subGenre, accountName: genreVM.accountName)
            let sheet = Sheet(year: year, month: month, genre: genre, amount: amount)
            createSheet(sheet: sheet)
            navigationController?.popViewController(animated: true)
        }
        print("amount: \(year), genre: \(month), amount: \(choseAmount), genre: \(choseGenre)")
    }
    
    func createSheet(sheet: Sheet) {
        sheetManager.addSheet(sheet: sheet)
    }

}

extension CreateLiabilitySheetTableViewController: ChoseItemDelegate {
    func choseItem(genre: SheetGenreListViewModel) {
        self.choseGenre = genre
        tableView.reloadData()
    }
}

extension CreateLiabilitySheetTableViewController: RightNumberFieldDelegate {
    func getNumberFieldValue(value: Int) {
        self.choseAmount = value
    }
}

extension CreateLiabilitySheetTableViewController: RightDatePickerDelegate {
    func getDatePickerValue(year: Int, month: Int) {
        self.choseYear = year
        self.choseMonth = month
    }
}
