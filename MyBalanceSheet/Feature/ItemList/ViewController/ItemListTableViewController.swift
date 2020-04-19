import UIKit

protocol ChoseItemDelegate: NSObject {
    func choseItem(genre: ItemCellViewModel)
}

class ItemListTableViewController: UITableViewController {
    
    @IBOutlet weak var btnContainer: UIView!
    @IBOutlet weak var createAssetSheetItemBtn: UIButton!
    weak var delegate: ChoseItemDelegate?
    
    // MARK: - Private
    
    var sheetType: SheetType?
    private let viewModel: ItemViewModel  = ItemViewModel()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.sheetType = sheetType!
        
        setNavigation()
        setTableView()
        setBtn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getGenreList()
        tableView.reloadData()
    }
    
    // MARK: - View Setting
    
    func setNavigation() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.title = viewModel.title
    }
    
    func setTableView() {
        tableView.backgroundColor = UIColor._app_background
        tableView.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ItemTableViewCell")
        tableView.register(UINib(nibName: "CreateItemTableViewCell", bundle: nil), forCellReuseIdentifier: "CreateItemTableViewCell")
    }
    
    func setBtn() {
        let btnImage = UIImage(systemName: "plus.circle.fill")
        btnContainer.backgroundColor = UIColor._app_background
        createAssetSheetItemBtn.layer.cornerRadius = 8
        
        switch sheetType! {
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
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sectionCount
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tableSection = GenreType(rawValue: section), let genre = viewModel.sortData[tableSection] {
            return genre.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath) as? ItemTableViewCell,
            let tableSection = GenreType(rawValue: indexPath.section),
        let genre = viewModel.sortData[tableSection]?[indexPath.row] else { return UITableViewCell() }
        
        cell.genre = genre
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        let row = indexPath.row
        
        if let tableSection = GenreType(rawValue: section), let genre = viewModel.sortData[tableSection]?[row], let d = delegate {
            d.choseItem(genre: genre)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let tableSection = GenreType(rawValue: indexPath.section), let genre = viewModel.sortData[tableSection]?[indexPath.row]  else { fatalError() }
        
        let deleteAction = UIContextualAction(style: .normal, title: "") { (action, sourceView, completionHandler) in
            self.deleteGenre(genreVM: genre)
            completionHandler(true)
        }
        
        deleteAction.backgroundColor = ._app_background
        deleteAction.image = UIImage(named: "deleteBtn")

        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
        swipeConfiguration.performsFirstActionWithFullSwipe = false

        return swipeConfiguration
    }
    
    func deleteGenre(genreVM: ItemCellViewModel) {
        let existed = viewModel.checkGenreExistInSheet(genre: genreVM)
        
        if existed == false {
            viewModel.delete(id: genreVM.id!)
            viewModel.getGenreList()
            self.tableView.reloadData()
        } else {
            let controller = UIAlertController(title: "注意", message: "該類別正在被使用中，若點選「確定」將會把該類別的紀錄都刪除，若是不想刪除，請選「取消」，先將過去紀錄更換類別在進行刪除", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "確定刪除", style: .default) { (_) in
                self.viewModel.delete(id: genreVM.id!)
                self.viewModel.getGenreList()
                self.tableView.reloadData()
            }
            controller.addAction(okAction)
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            controller.addAction(cancelAction)
            present(controller, animated: true, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let tableSection = GenreType(rawValue: section) else { return "" }
            
        return viewModel.sectionTitle[tableSection]
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = CellHeaderView(frame: CGRect(x: 10, y: 20, width: tableView.frame.size.width, height: 20))
        headerView.titleLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        return headerView
    }
    
    // MARK: - Action
    @IBAction func toCreateAssetSheetItemPage(_ sender: Any) {
        let storyboard = UIStoryboard(name: "ItemManagement", bundle: nil)
        
        if let vc = storyboard.instantiateViewController(withIdentifier: "ItemManagement") as? CreateItemTableViewController {
            vc.sheetType = sheetType
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            fatalError("page not found")
        }
    }
}
