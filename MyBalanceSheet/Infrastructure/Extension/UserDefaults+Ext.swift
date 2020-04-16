import Foundation

extension UserDefaults {
    enum Key {
        case `default`(key: String)
        init(key: String) {
            self = .default(key: key)
        }
    }
    
    func isFirstLaunch() -> Bool {
        let flag = "hasBeenLaunchedBeforeFlag"
        let isFirstLaunch = !UserDefaults.standard.bool(forKey: flag)
        if (isFirstLaunch) {
            UserDefaults.standard.set(true, forKey: flag)
            UserDefaults.standard.synchronize()
        }
        return isFirstLaunch
    }
    
    func isFaceIDOn() -> Bool {
        let flag = "hasBeenTurnedOnFaceIDFlag"
        UserDefaults.standard.checkFaceIDExist()
        return UserDefaults.standard.bool(forKey: flag)
    }
    
    func toggleFaceID() {
        let flag = "hasBeenTurnedOnFaceIDFlag"
        UserDefaults.standard.checkFaceIDExist()
        let isFaceIDOn = !UserDefaults.standard.bool(forKey: flag)
        UserDefaults.standard.set(isFaceIDOn, forKey: flag)
        UserDefaults.standard.synchronize()
        
        print("now, \(self.isFaceIDOn())")
    }
    
    private func checkFaceIDExist() {
        let flag = "hasBeenTurnedOnFaceIDFlag"
        let isExisted = UserDefaults.standard.object(forKey: flag)
        if (isExisted == nil) {
            UserDefaults.standard.set(false, forKey: flag)
            UserDefaults.standard.synchronize()
        }
    }
    
}
