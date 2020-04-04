import Foundation
import CoreData


extension Genre {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Genre> {
        return NSFetchRequest<Genre>(entityName: "Genre")
    }

    @NSManaged public var accountName: String?
    @NSManaged public var genreType: Int16
    var genreEnum: GenreType{
        get { return GenreType(rawValue: Int(self.genreType)) ?? .current }
        set { self.genreType = Int16(newValue.rawValue) }
    }
    @NSManaged public var icon: String?
    @NSManaged public var id: UUID?
    @NSManaged public var sheetType: Int16
    var sheetEnum: SheetType{
        get { return SheetType(rawValue: Int(self.sheetType)) ?? .asset }
        set { self.sheetType = Int16(newValue.rawValue) }
    }
    @NSManaged public var genre: NSSet?

}

// MARK: Generated accessors for genre
extension Genre {

    @objc(addGenreObject:)
    @NSManaged public func addToGenre(_ value: Sheet)

    @objc(removeGenreObject:)
    @NSManaged public func removeFromGenre(_ value: Sheet)

    @objc(addGenre:)
    @NSManaged public func addToGenre(_ values: NSSet)

    @objc(removeGenre:)
    @NSManaged public func removeFromGenre(_ values: NSSet)

}
