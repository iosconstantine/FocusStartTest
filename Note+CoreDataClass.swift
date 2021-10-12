//
//  Note+CoreDataClass.swift
//  FocusStartTestApplication
//
//  Created by KONSTANTIN TISHCHENKO on 11.10.2021.
//
//

import Foundation
import CoreData

@objc(Note)
public class Note: NSManagedObject {

    var title: String {
        return text.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines).first ?? "" // Возвращает первую строку
    }
    
    var descriptionText: String {
        var lines = text.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines)
        lines.removeFirst()
        return "\(lastUpdated.format()) \(lines.first ?? "")" // Возвращает вторую строку
    }
}
