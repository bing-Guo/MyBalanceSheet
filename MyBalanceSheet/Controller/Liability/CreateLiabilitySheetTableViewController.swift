import UIKit

class CreateLiabilitySheetTableViewController: UITableViewController {

    var choseGenre: SheetGenreListViewModel?
    var choseAmount: Int?
    let sheetManager = SheetManager.shareInstance
    
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
        tableView.backgroundColor = UIColor._standard_light_gray
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "RightTextTableViewCell", bundle: nil), forCellReuseIdentifier: "RightTextTableViewCell")
        tableView.register(UINib(nibName: "RightNumberFieldTableViewCell", bundle: nil), forCellReuseIdentifier: "RightNumberFieldTableViewCell")
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
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
                let cell = tableView.dequeueReusableCell(withIdentifier: "RightTextTableViewCell", for: indexPath) as! RightTextTableViewCell
                cell.setup(leftLabelString: "選擇貨幣", rightLabelString: "貨幣")
                
                return cell
            case 2:
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
        if let genreVM = choseGenre {
            // todo
            let genre = Genre(id: genreVM.id, mainGenre: genreVM.mainGenre, subGenre: genreVM.subGenre, accountName: genreVM.accountName)
            let sheet = Sheet(year: 2020, month: 3, genre: genre, amount: amount)
            createSheet(sheet: sheet)
            navigationController?.popViewController(animated: true)
        }
        print("amount: \(choseAmount), genre: \(choseGenre)")
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
