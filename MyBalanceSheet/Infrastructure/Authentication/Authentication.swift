import Foundation
import LocalAuthentication

enum Result<String> {
    case success
    case failure(String)
}

class Authentication {
    private init() {}
    
    static var shared = Authentication()
    
    func isBiometricAvailable(completion: @escaping (_ result: Result<String>) -> ()) {
        let localAuthContext = LAContext()
        let reasonText = "驗證以打開「MyBalanceSheet」"

        localAuthContext.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: reasonText, reply: { (success: Bool, error: Error?) -> Void in
            // Failure workflow
            if !success {
                if let error = error {
                    switch error {
                    case LAError.authenticationFailed:
                        completion(.failure("Authentication failed"))
                    case LAError.passcodeNotSet:
                        completion(.failure("Passcode not set"))
                    case LAError.systemCancel:
                        completion(.failure("Authentication was canceled by system"))
                    case LAError.userCancel:
                        completion(.failure("Authentication was canceled by the user"))
                    case LAError.biometryNotEnrolled:
                        completion(.failure("Authentication could not start because you haven't enrolled either Touch ID or Face ID on your device."))
                    case LAError.biometryNotAvailable:
                        completion(.failure("Authentication could not start because Touch ID / Face ID is not available."))
                    case LAError.userFallback:
                        completion(.failure("User tapped the fallback button (Enter Password)."))
                    default:
                        completion(.failure(error.localizedDescription))
                    }
                }
                
            } else {
                completion(.success)
                print("Successfully authenticated")
            }
        })
    }
    
    func isAuthenticationcAvailable(completion: @escaping (_ result: Result<String>) -> ()) {
        let localAuthContext = LAContext()
        let reasonText = "驗證以打開「MyBalanceSheet」"

        localAuthContext.evaluatePolicy(LAPolicy.deviceOwnerAuthentication, localizedReason: reasonText, reply: { (success: Bool, error: Error?) -> Void in
            // Failure workflow
            if !success {
                if let error = error {
                    switch error {
                    case LAError.authenticationFailed:
                        completion(.failure("Authentication failed"))
                    case LAError.passcodeNotSet:
                        completion(.failure("Passcode not set"))
                    case LAError.systemCancel:
                        completion(.failure("Authentication was canceled by system"))
                    case LAError.userCancel:
                        completion(.failure("Authentication was canceled by the user"))
                    case LAError.biometryNotEnrolled:
                        completion(.failure("Authentication could not start because you haven't enrolled either Touch ID or Face ID on your device."))
                    case LAError.biometryNotAvailable:
                        completion(.failure("Authentication could not start because Touch ID / Face ID is not available."))
                    case LAError.userFallback:
                        completion(.failure("User tapped the fallback button (Enter Password)."))
                    default:
                        completion(.failure(error.localizedDescription))
                    }
                }
                
            } else {
                completion(.success)
                print("Successfully authenticated")
            }
        })
    }
}

