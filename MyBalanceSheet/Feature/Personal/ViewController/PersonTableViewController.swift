import UIKit

class PersonTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigation()
         setTabBar()
        setTableView()
    }
    
    func setNavigation() {
        self.title = "個人"
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor._summary_background
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor._summary_text]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor._summary_text]
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.tintColor = ._summary_text
    }

     func setTabBar() {
         self.tabBarController?.tabBar.tintColor = ._summary_background
     }
    
    func setTableView() {
        tableView.backgroundColor = UIColor._app_background
        tableView.register(UINib(nibName: "RightTextTableViewCell", bundle: nil), forCellReuseIdentifier: "RightTextTableViewCell")
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RightTextTableViewCell", for: indexPath) as! RightTextTableViewCell
            cell.setup(leftLabelString: "隱私權", rightLabelString: "")
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RightTextTableViewCell", for: indexPath) as! RightTextTableViewCell
            cell.setup(leftLabelString: "感謝", rightLabelString: "")
            return cell
        default:
            break
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Personal", bundle: nil)
        
        switch indexPath.row {
        case 0:
            if let vc = storyboard.instantiateViewController(withIdentifier: "privacyPage") as? PrivacyTableViewController {
                self.navigationController?.pushViewController(vc, animated: true)
            }
            break
        case 1:
            if let vc = storyboard.instantiateViewController(withIdentifier: "thanksPage") as? ThanksForTableViewController {
                self.navigationController?.pushViewController(vc, animated: true)
            }
            break
        default:
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
}
