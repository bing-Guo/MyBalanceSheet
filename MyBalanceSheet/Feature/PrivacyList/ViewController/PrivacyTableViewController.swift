import UIKit

class PrivacyTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigation()
        setTableView()
    }
    
    func setNavigation() {
        self.title = "隱私"
        
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
        tableView.register(UINib(nibName: "RightSwitchTableViewCell", bundle: nil), forCellReuseIdentifier: "RightSwitchTableViewCell")
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RightSwitchTableViewCell", for: indexPath) as! RightSwitchTableViewCell
        cell.setup(leftLabelString: "使用Face ID鎖定")
        cell.delegate = self
        
        cell.rightSwitch.setOn(UserDefaults.standard.isFaceIDOn(), animated: false)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
}

extension PrivacyTableViewController: RightSwitchDelegate {
    func getSwitchValue(uiSwitch: UISwitch) {
        let currentSwitchValue = UserDefaults.standard.isFaceIDOn()
        
        Authentication.shared.isBiometricAvailable() { bioResult in
            switch bioResult {
                
            case .success:
                DispatchQueue.main.async {
                    UserDefaults.standard.toggleFaceID()
                }
                break
                
            case .failure(let errorString):
                print("bio: \(errorString)")
                
                Authentication.shared.isAuthenticationcAvailable() { autResult in
                    switch autResult {
                        
                    case .success:
                        DispatchQueue.main.async {
                            UserDefaults.standard.toggleFaceID()
                        }
                        break
                        
                    case .failure(let errString):
                        DispatchQueue.main.async {
                            uiSwitch.setOn(currentSwitchValue, animated: true)
                            print("aut: \(errString)")
                        }
                        
                        break
                    }
                    
                }
                
                break
            }
        }
    }
}
