import UIKit

class ThanksForTableViewController: UITableViewController {
    
    var thanksData: [ThanksModelView]?
    var data = [ThanksType: [ThanksModelView]]()
    let thanksManager = ThanksManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigation()
        setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        thanksData = getData()
        sortData()
    }
    
    func setNavigation() {
        self.title = "感謝"
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor._summary_background
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor._summary_text]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor._summary_text]
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    func setTableView() {
        tableView.backgroundColor = UIColor._app_background
        tableView.register(UINib(nibName: "RightTextTableViewCell", bundle: nil), forCellReuseIdentifier: "RightTextTableViewCell")
    }
    
    func getData() -> [ThanksModelView] {
        return thanksManager.getThanksIconList()
    }
    
    func sortData() {
        guard let filterGenreData = thanksData else { return }
        
        data[.icons] = filterGenreData.filter({ $0.type == .icons })
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tableSection = ThanksType(rawValue: section), let thanks = data[tableSection] {
            return thanks.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        
        if let tableSection = ThanksType(rawValue: section), let thanks = data[tableSection]?[row] {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RightTextTableViewCell", for: indexPath) as! RightTextTableViewCell
            cell.setup(leftLabelString: thanks.display, rightLabelString: "")
            return cell
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        let row = indexPath.row
        
        if let tableSection = ThanksType(rawValue: section), let thanks = data[tableSection]?[row] {
            let storyboard = UIStoryboard(name: "Personal", bundle: nil)
            if let vc = storyboard.instantiateViewController(withIdentifier: "thanksDetailPage") as? ThanksDetailViewController {
                vc.thankVM = thanks
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
}
