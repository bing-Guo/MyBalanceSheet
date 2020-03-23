import Foundation
import CoreData
import UIKit

//class StorgeManager {
//    let persistentContainer: NSPersistentContainer!
//    
//    //MARK: Init with dependency
//    init(container: NSPersistentContainer) {
//        self.persistentContainer = container
//        self.persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
//    }
//    
//    convenience init() {
//        //Use the default container for production environment
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//            fatalError("Can not get shared app delegate")
//        }
//        self.init(container: appDelegate.persistentContainer)
//    }
//    
//    lazy var backgroundContext: NSManagedObjectContext = {
//        return self.persistentContainer.newBackgroundContext()
//    }()
//    
//    //MARK: CRUD
//    func insertSheet( date: Date, item: String, value: Int32 ) -> Sheet? {
//        guard let sheet = NSEntityDescription.insertNewObject(forEntityName: "Sheet", into: backgroundContext) as? Sheet else { return nil }
//        
//        sheet.date = date
//        sheet.item = item
//        sheet.value = value
//
//        return sheet
//    }
//
//    func fetchAll() -> [Sheet] {
//        let request: NSFetchRequest<Sheet> = Sheet.fetchRequest()
//        let results = try? persistentContainer.viewContext.fetch(request)
//        return results ?? [Sheet]()
//    }
//
//    func remove( objectID: NSManagedObjectID ) {
//        let obj = backgroundContext.object(with: objectID)
//        backgroundContext.delete(obj)
//    }
//
//    func save() {
//        if backgroundContext.hasChanges {
//            do {
//                try backgroundContext.save()
//            } catch {
//                print("Save error \(error)")
//            }
//        }
//
//    }
//}
