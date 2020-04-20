import Foundation
import CoreData
import UIKit

class ItemStorageManager {

    let persistentContainer: NSPersistentContainer!

    init(container: NSPersistentContainer) {
        self.persistentContainer = container
        self.persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
    }
        
    convenience init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Can not get shared app delegate")
        }
        self.init(container: appDelegate.persistentContainer)
    }
    
    lazy var backgroundContext: NSManagedObjectContext = {
        return self.persistentContainer.newBackgroundContext()
    }()
    
    func insert(accountName: String, genreType: GenreType, icon: String, sheetType: SheetType) -> Genre? {
        
        guard let obj = NSEntityDescription.insertNewObject(forEntityName: "Genre", into: backgroundContext) as? Genre else { return nil }
        
        obj.id = UUID()
        obj.accountName = accountName
        obj.genreType = Int16(genreType.rawValue)
        obj.icon = icon
        obj.sheetType = Int16(sheetType.rawValue)
        
        return obj
    }
    
    func fetchAll() -> [Genre] {
        let request: NSFetchRequest<Genre> = Genre.fetchRequest()
        let results = try? persistentContainer.viewContext.fetch(request)
        return results ?? [Genre]()
    }
    
    func remove( objectID: NSManagedObjectID ) {
        let obj = backgroundContext.object(with: objectID)
        backgroundContext.delete(obj)
    }
    
    func save() {
        if backgroundContext.hasChanges {
            do {
                try backgroundContext.save()
            } catch {
                print("Save error \(error)")
            }
        }
        
    }
}
