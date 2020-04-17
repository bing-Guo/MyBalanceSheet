import Foundation
import CoreData
import UIKit

enum CoreDataError: Error {
    case InconsistentCoreDataFetchRequestResults
}

class CoreDataConnction<T: NSManagedObject> {
    
    private var entityName: String {
        return String(describing: T.self)
    }
    private var context : NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    private var entity: NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: entityName, in: context)!
    }
    
    func retrieve() throws -> [T] {
        return try self.retrieve(predicate: nil)
    }

    func retrieve(predicate: NSPredicate?) throws -> [T] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        if let properPredicate = predicate {
            request.predicate = properPredicate
        }
        let results = try context.fetch(request)
        
        guard let properResults = results as? [T] else {
            throw CoreDataError.InconsistentCoreDataFetchRequestResults
        }
        
        return properResults
    }
    
    func insert(attributes: [String: Any]) throws {
        let obj = NSManagedObject(entity: entity, insertInto: context)
        
        for attribute in attributes {
            obj.setValue(attribute.value, forKey: attribute.key)
        }
        
        try context.save()
    }
    
    func update(predicate: NSPredicate?, attributes: [String: Any]) throws {
        let reuslts = (predicate == nil) ? try self.retrieve() : try self.retrieve(predicate: predicate)
        
        for obj in reuslts {
            for attribute in attributes {
                obj.setValue(attribute.value, forKey: attribute.key)
            }
            try context.save()
        }
    }
    
    func delete(predicate: NSPredicate?) throws {
        let reuslts = (predicate == nil) ? try self.retrieve() : try self.retrieve(predicate: predicate)
        
        for obj in reuslts {
            context.delete(obj)
            try context.save()
        }
    }
}
