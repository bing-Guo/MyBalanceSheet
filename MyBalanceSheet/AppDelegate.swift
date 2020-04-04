import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var optionallyStoreTheFirstLaunchFlag = false

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        optionallyStoreTheFirstLaunchFlag = UserDefaults.isFirstLaunch()
        print("optionallyStoreTheFirstLaunchFlag: \(optionallyStoreTheFirstLaunchFlag)")
        if optionallyStoreTheFirstLaunchFlag {
            loadDefault()
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "MyBalanceSheet")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func loadDefault() {
        let manager = GenreManager.shareInstance
        let url = Bundle.main.url(forResource: "Genre", withExtension: "plist")!
                
        let plistArray : NSArray = NSArray(contentsOf: url)!
        for item in plistArray {
            let itemDict: [String: Any] = item as! [String : Any]
            if let accountName = itemDict["accountName"] as? String,
                let genreType = GenreType(rawValue: itemDict["genreType"] as? Int ?? 0),
                let icon = itemDict["icon"] as? String,
                let sheetType = SheetType(rawValue: itemDict["sheetType"] as? Int ?? 0) {
                manager.addGenre(accountName: accountName,
                                 genreType: genreType,
                                icon: icon,
                                sheetType: sheetType)
            }
        }
    }

}

