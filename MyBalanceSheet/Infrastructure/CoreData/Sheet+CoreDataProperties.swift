import Foundation
import CoreData


extension Sheet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Sheet> {
        return NSFetchRequest<Sheet>(entityName: "Sheet")
    }

    @NSManaged public var amount: Int32
    @NSManaged public var id: UUID?
    @NSManaged public var month: Int16
    @NSManaged public var name: String?
    @NSManaged public var year: Int16
    @NSManaged public var genre: Genre?

}
