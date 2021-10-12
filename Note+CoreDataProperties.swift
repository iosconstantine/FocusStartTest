//
//  Note+CoreDataProperties.swift
//  FocusStartTestApplication
//
//  Created by KONSTANTIN TISHCHENKO on 11.10.2021.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var lastUpdated: Date!
    @NSManaged public var text: String!
    @NSManaged public var id: UUID!

}

extension Note : Identifiable {

}
