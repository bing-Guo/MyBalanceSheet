import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
    }
    
    func setView() {
        loginButton.layer.cornerRadius = loginButton.frame.width/2
        loginButton.backgroundColor = .white
        loginButton.imageView?.tintColor = UIColor(hex: "#98D5D7")
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if !UserDefaults.standard.isFaceIDOn() {
            toHomePage()
        } else {
            loginBiometricAuthentication()
        }
    }
    
    @objc func loginButtonTapped() {
        loginBiometricAuthentication()
    }
    
    func toHomePage() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "HomePage") as? CustomTabBarViewController {
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false)
        }
    }
    
    func loginBiometricAuthentication() {
        Authentication.shared.isBiometricAvailable() { bioResult in
            switch bioResult {
            case .success:
                DispatchQueue.main.async {
                    self.toHomePage()
                }
                break
            case .failure(let errorString):
                print("bio: \(errorString)")
                self.loginAuthentication()
                break
            }
        }
    }
    
    func loginAuthentication() {
        Authentication.shared.isAuthenticationcAvailable() { autResult in
            switch autResult {
            case .success:
                DispatchQueue.main.async {
                    self.toHomePage()
                }
                break
            case .failure(let errString):
                DispatchQueue.main.async {
                    print("aut: \(errString)")
                }
                break
            }
        }
    }
}
