import UIKit

class CreateAssetSheetGenreTableViewController: UITableViewController {
    
    @IBOutlet weak var createBtn: UIBarButtonItem!
    
    var newSubGenre: String?
    var newAccountName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
    }
    
    func setTableView() {
        tableView.backgroundColor = UIColor._standard_light_gray
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "RightTextFieldTableViewCell", bundle: nil), forCellReuseIdentifier: "RightTextFieldTableViewCell")
        tableView.register(UINib(nibName: "RightPickerTableViewCell", bundle: nil), forCellReuseIdentifier: "RightPickerTableViewCell")
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        
        switch row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RightTextFieldTableViewCell", for: indexPath) as! RightTextFieldTableViewCell
            cell.delegate = self
            cell.leftTextLabel.text = "名稱"
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RightPickerTableViewCell", for: indexPath) as! RightPickerTableViewCell
            cell.delegate = self
            cell.leftTextLabel.text = "資產類型"
            return cell
        default:
            break
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    // MARK: - Action
    @IBAction func CreateAssetItem(_ sender: Any) {
        let subGenre = newSubGenre ?? "current"
        
        if let accountName = newAccountName {
            addAssetItem(subGenre: subGenre, accountName: accountName)
            self.navigationController?.popViewController(animated: true)
        }else{
            print("subGenre: \(newSubGenre), accountName: \(newAccountName)")
        }
    }
    
    func addAssetItem(subGenre: String, accountName: String) {
        let genre = Genre(id: "000", mainGenre: "資產", subGenre: subGenre, accountName: accountName)
        Database.genres.append(genre)
        print(Database.genres)
    }
}

extension CreateAssetSheetGenreTableViewController: RightTextFieldValueDelegate {
    func getTextFieldValue(value: String) {
        newAccountName = value
    }
}

extension CreateAssetSheetGenreTableViewController: RightPickerValueDelegate {
    func getPickerValue(value: String) {
        newSubGenre = value
    }
}
